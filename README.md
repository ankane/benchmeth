# Benchmeth

The super easy way to benchmark methods in a live application

```ruby
class Person
  def compute
    # boom
  end
  benchmark :compute
end
```

Works with class methods, too

```ruby
class Person
  def self.compute
    # yolo
  end
  class << self
    benchmark :compute
  end
end
```

## Installation

Add this line to your application’s Gemfile:

```ruby
gem "benchmeth"
```

## How to Use

By default, benchmark data is written to `stdout` in the following format:

```
compute : 1000 ms
```

but you can easily do whatever you want with it.

```ruby
Benchmeth.on_benchmark do |method_name, seconds|
  puts "#{method_name} took #{seconds} seconds!"
end
```

To call a method without benchmarking, append `_without_benchmark` to the name.

## ActiveSupport Notifications

You can switch to ActiveSupport notifications with:

```ruby
Benchmeth.use_notifications = true
```

And subscribe with:

```ruby
ActiveSupport::Notifications.subscribe "benchmark.benchmeth" do |*args|
  event = ActiveSupport::Notifications::Event.new(*args)
  puts "%s : %d ms" % [event.payload[:name], event.duration]
end
```

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/benchmeth/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/benchmeth/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development:

```sh
git clone https://github.com/ankane/benchmeth.git
cd benchmeth
bundle install
bundle exec rake test
```
