# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bun/version'

Gem::Specification.new do |spec|
  spec.name          = 'bun'
  spec.version       = Bun::VERSION
  spec.authors       = ['k1LoW']
  spec.email         = ['k1lowxb@gmail.com']

  spec.summary       = 'Lazy Japanese paragraph extractor'
  spec.description   = 'Extract one japanese paragraph from one line'
  spec.homepage      = 'https://github.com/k1LoW/bun'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.1'
  spec.add_runtime_dependency 'natto'
  spec.add_runtime_dependency 'ltsv'
  spec.add_runtime_dependency 'thor'
  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
end
