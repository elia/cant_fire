require 'cant_fire/version'

module CantFire
  extend self

  def start!
    require 'term/ansicolor'
    String.send :include, Term::ANSIColor

    colors = %w[red green yellow blue magenta cyan white]

    room_colors = {all: colors.dup}
    user_colors = {all: colors.dup}

    require 'thread'
    @rooms = campfire.rooms.map do |room|
      next if config.skip_rooms.include? room.name
      Thread.new do
        room_colors[:all] = colors.dup if room_colors[:all].empty?
        room_colors[room.name] ||= room_colors[:all].shift
        room_color = room_colors[room.name]

        puts "Connecting to #{room.name.inspect}".send(room_color)
        room.listen do |message|
          next unless message.body and message.user

          user = message.user

          user_colors[:all] = colors.dup if user_colors[:all].empty?
          user_colors[user.name] ||= user_colors[:all].shift
          user_color = user_colors[user.name]

          puts "[#{room.name}] ".send(room_color) +
               "**#{user.name}**:".send(user_color) +
               " #{message.body}"

          case message.body
          when /(#{config.username}|\ball\b)/i
            url = "https://#{config.subdomain}.campfirenow.com/room/#{room.id}#message_#{message.id}"
            notify message.body,
                   title: "#{user.name} is calling you!",
                   subtitle: room.name,
                   open: url,
                   group: "Campfire - #{room.name}"
            # Notify.notify summary, message.body
            # Notify.notify "New message on room #{room.name.inspect}: \n#{message.body}"
          end
        end
      end
    end.compact

    @rooms.each(&:join)
  end


  class ConfigError < StandardError
  end

  def check_config!
    config
  end


  private

  def config
    @config ||= begin
      require 'ostruct'
      require 'yaml'
      config_path = File.expand_path('~/.cant_fire')
      raise ConfigError.new("Please setup your config file first in: #{config_path}") unless File.exist? config_path
      OpenStruct.new YAML.load_file(config_path)
    end
  end

  def campfire
    @campfire ||= begin
      require 'tinder'
      Tinder::Campfire.new config.subdomain, :token => config.token
    end
  end

  def puts *args
    print args.join("\n") << "\n"
  end

  def notify message, options
    require 'shellwords'
    fork { exec "say #{options[:title].shellescape}" }
    require 'terminal-notifier'
    # TerminalNotifier.notify('Hello World', :title => 'Ruby', :subtitle => 'Programming Language')
    # TerminalNotifier.notify('Hello World', :activate => 'com.apple.Safari')
    # TerminalNotifier.notify('Hello World', :open => 'http://twitter.com/alloy')
    # TerminalNotifier.notify('Hello World', :execute => 'say "OMG"')
    # TerminalNotifier.notify('Hello World', :group => Process.pid)
    TerminalNotifier.notify(message, options)
  end
end
