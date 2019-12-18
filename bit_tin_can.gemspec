# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'big_tin_can/version'

Gem::Specification.new do |spec|
  spec.name          = 'big_tin_can'
  spec.version       = BigTinCan::VERSION
  spec.authors       = ["Greg Benedict"]
  spec.email         = ["gbenedict@gmail.com"]
  spec.date          = %q{2019-12-18}

  spec.summary       = %q{This is a wrapper for the BigTinCan public API}
  spec.description   = %q{This is a wrapper for the BigTinCan public API}
  spec.homepage      = "https://github.com/gbenedict/big_tin_can"
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(benchmark|test|spec|features|examples)/}) }

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'httparty', '~> 0.17.1'
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.3'
end
