# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fip/version'

Gem::Specification.new do |spec|
  spec.name          = "fip"
  spec.version       = Fip::VERSION
  spec.authors       = ["Marcelo Goncalves"]
  spec.email         = ["marcelocg@gmail.com"]
  spec.description   = %q{A wrapper for the Find My iPhone Apple API}
  spec.summary       = %q{A wrapper for the Find My iPhone Apple API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.4"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "httparty", "~> 0.21.0"
end
