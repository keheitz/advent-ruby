# Advent of Code 2020, 2021, 2023 (ruby)

Command utility to run advent of code solutions for 2020 in Ruby. Each day I plan to solve it as fast as I can using what I know and google, and then I'll try to refactor in the evening after learning from other folks solutions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'advent'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install advent

## Usage

To run after installation, you can see part 1 and 2 for any given day by running 
```bash
advent solve {day}
```
Where {day} is the number of the day you wish to solve. For example
```bash
advent solve four
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
