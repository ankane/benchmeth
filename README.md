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

Subscribe to notifications with:

```ruby
ActiveSupport::Notifications.subscribe "benchmark.benchmeth" do |name, started, finished, unique_id, data|
  puts "%s : %d ms" % [data[:name], (finished - started) * 1000]
end
```

To call a method without benchmarking, append `_without_benchmark`.

## Installation

Add this line to your application’s Gemfile:

```ruby
gem 'benchmeth'
```

And then execute:

```sh
bundle
```

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/benchmeth/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/benchmeth/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features
