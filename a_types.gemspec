# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'a_types/version'

Gem::Specification.new do |spec|
  spec.name          = 'a_types'
  spec.version       = ATypes::VERSION
  spec.authors       = ['Yves Komenda']
  spec.email         = ['b_d_v@web.de']

  spec.summary       = "Provides advanced versions of Ruby's basic datatypes"
  spec.description   = "Provides advanced versions of Ruby's basic datatypes"
  spec.homepage      = 'https://github.com/Dervol03/a_types'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(spec)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry', '~> 0.10'
end
