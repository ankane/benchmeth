# -*- encoding: utf-8 -*-
require File.expand_path('../lib/benchmeth/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Andrew Kane"]
  gem.email         = ["andrew@getformidable.com"]
  gem.description   = %q{The super easy way to benchmark methods}
  gem.summary       = %q{The super easy way to benchmark methods}
  gem.homepage      = "https://github.com/ankane/benchmeth"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "benchmeth"
  gem.require_paths = ["lib"]
  gem.version       = Benchmeth::VERSION
end
