# CantFire

Use the terminal and your favorite editor to chat in CampFire

**NOTICE:** for now it's OSX ML only

## Installation

Install as a gem:

    $ gem install cant_fire

Setup credentials in `~/.cant_fire`

```yaml
subdomain: your_campfire_subdomain
token: o487yfi8yeig8fy75weoh8gyoe8rhy5goer87ygehr587ygo8e
username: name
terminal_notifier: true
skip_rooms:
  - 'Dumbs'
  - 'Boring'
```



## Usage

Get notified via the notification center, hit `CTRL+C` to open your configured `$EDITOR` to write the message


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
