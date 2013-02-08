# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'linepipe/version'

Gem::Specification.new do |gem|
  gem.name          = "linepipe"
  gem.version       = Linepipe::VERSION
  gem.authors       = ["Josep M. Bach"]
  gem.email         = ["josep.m.bach@gmail.com"]
  gem.description   = %q{Process data in a maintainable and easily testable way.}
  gem.summary       = %q{Process data in a maintainable and easily testable way.}
  gem.homepage      = "https://github.com/wimdu/linepipe"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
end
