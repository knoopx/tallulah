# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tallulah/version'

Gem::Specification.new do |spec|
  spec.name = "tallulah"
  spec.version = Tallulah::VERSION
  spec.authors = ["Victor Martinez"]
  spec.email = ["knoopx@gmail.com"]
  spec.description = %q{Yet another ruby-based template engine}
  spec.summary = %q{Yet another ruby-based template engine}
  spec.homepage = ""
  spec.license = "MIT"

  spec.files = `git ls-files`.split($/)
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "activesupport", ">= 3.2"
  spec.add_development_dependency "actionpack", ">= 3.2"
end
