# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'linepipe/version'

Gem::Specification.new do |gem|
  gem.name          = "linepipe"
  gem.version       = Linepipe::VERSION
  gem.authors       = ["Josep M. Bach"]
  gem.email         = ["josep.bach@wimdu.com"]
  gem.description   = %q{Process data one step at a time.}
  gem.summary       = %q{Process data one step at a time.}
  gem.homepage      = "http://wimdu.github.com/linepipe"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rake'
end
