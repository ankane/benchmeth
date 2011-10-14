# Benchmeth

The super easy way to benchmark methods.

```ruby
gem "benchmeth"
```

Just say which methods to benchmark and what you'd like to do with the results.

```ruby
def compute
  puts "CRUNCH!!"
end

benchmeth :compute do |method_name, realtime|
  puts "%s : %.2f ms" % [method_name, realtime * 1000]
  # Or log them.
end

compute

# Output:
# CRUNCH!!
# compute : 0.09 ms
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
  benchmeth :work, :play do |method_name, realtime|
    puts "%s : %.2f ms" % [method_name, realtime * 1000]
  end

end
```

## Class Methods

```ruby
class Person

  def self.count
    2
  end

  class << self
    benchmeth :count do |method_name, realtime|
      puts "%s : %.2f ms" % [method_name, realtime * 1000]
    end
  end

end
```
