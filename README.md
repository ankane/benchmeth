# Benchmeth

The super easy way to benchmark methods in a live application

```ruby
class Person

  def work(seconds)
    sleep(seconds)
  end
  benchmark :work

end
```

Works with class methods, too

```ruby
class Person

  def self.find(id)
    sleep(2)
  end
  class << self
    benchmark :find
  end

end
```

By default, benchmark data is written to STDOUT in the following format:

```
compute : 1000 ms
```

but you can easily do whatever you want with it.

```ruby
Benchmeth.on_benchmark do |method, realtime|
  # Log to a file
  logger.info "#{method} took #{realtime} seconds!"

  # Record a random sample of 1% of calls
  puts realtime if rand < 0.01

  # The default is
  puts "%s : %d ms" % [method, realtime * 1000]
end
```

To call a method without benchmarking, use:

```ruby
compute_without_benchmark
```

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
