require_relative "lib/benchmeth/version"

Gem::Specification.new do |spec|
  spec.name          = "benchmeth"
  spec.version       = Benchmeth::VERSION
  spec.summary       = "The super easy way to benchmark methods"
  spec.homepage      = "https://github.com/ankane/benchmeth"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@ankane.org"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.4"
end
