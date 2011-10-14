# Benchmeth

The super easy way to benchmark methods.

```ruby
gem "benchmeth"
```

Just say which methods to benchmark.

```ruby
def compute
  sleep(1)
end

benchmark :compute

compute
```

By default, benchmark data is written to STDOUT

```
compute : 1000 ms
```

but you can easily do whatever you want with it.

```ruby
Benchmeth.on_benchmark do |method, realtime|
  logger.info "#{method} took #{realtime} seconds!"
  # The default is:
  # puts "%s : %d ms" % [method, realtime * 1000]
end
```

To call a method without benchmarking, use:

```ruby
compute_without_benchmark
```

## Instance Methods

```ruby
class Person

  def work(seconds)
    puts "Working for #{seconds} seconds"
    sleep(seconds)
  end

  def play
    puts "Time to play!"
    sleep(rand * 4)
  end

  # This must come after the methods are defined.
  benchmark :work, :play

end

person = Person.new
person.work(1)
person.play
```

Like rdoc, instance methods are denoted with a pound sign (#).

```
Person#work : 1000 ms
Person#play : 500 ms
```

## Class Methods

```ruby
class Person

  def self.find(id)
    puts "Found person #{id}!"
  end

  class << self
    benchmark :find
  end

end

Person.find(1)
```

Like rdoc, class methods are denoted with a dot (.).

```
Person.find : 0 ms
```
