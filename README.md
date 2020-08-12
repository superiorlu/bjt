# bjt

bjt(bundle jump to), a quick navigation tool for bundle packages like [njt](https://github.com/kachkaev/njt).

[![Gem Version](http://img.shields.io/gem/v/bjt.svg)](https://rubygems.org/gems/bjt)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bjt'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bjt

## Usage

```shell
   bundle exec bjt

bjt commands:
  bjt g               # Jump To Github or Gitlab
  bjt h               # Jump To Homepage
  bjt help [COMMAND]  # Describe available commands or one specific command
  bjt l               # Jump To Local Dir
  bjt p               # Jump To Gems Repos
  bjt r               # Jump To Releases
  bjt s               # Jump To Source
```

## Examples

`bjt h bundler` (homepage)  
→ <https://bundler.io/>

`bjt g bundler` (github)  
→ <https://github.com/rubygems/bundler>

`bjt p bundler` (rubygems)  
→ <https://rubygems.org/gems/bundler>

`bjt s bundler` (source)  
→ <https://github.com/rubygems/bundler>

`bjt r bundler` (release)  
→ <https://github.com/rubygems/bundler/releases>

`bjt l bundler` (Gem Installed Dir)  
→ Open Folder: /Users/x/.rbenv/versions/2.x.x/lib/ruby/gems/2.x.x/gems/bundler-x.x.x

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/superiorlu/bjt.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
