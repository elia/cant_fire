# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cant_fire/version'

Gem::Specification.new do |gem|
  gem.name          = 'cant_fire'
  gem.version       = CantFire::VERSION
  gem.authors       = ['Elia Schito']
  gem.email         = ['elia@schito.me']
  gem.description   = %q{Keep an ear in every campfire room, get notified with Notification Center, use the Terminal}
  gem.summary       = %q{A notifier for Campfire, open the browser only when needed}
  gem.homepage      = 'http://github.com/elia/cant_fire'
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'tinder'
  gem.add_runtime_dependency 'terminal-notifier'
  gem.add_runtime_dependency 'term-ansicolor'
end
