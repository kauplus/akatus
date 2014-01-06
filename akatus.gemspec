# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'akatus/version'

Gem::Specification.new do |spec|
  spec.name          = 'akatus'
  spec.version       = Akatus::VERSION
  spec.author        = 'Kauplus'
  spec.email         = 'tech@kauplus.com.br'
  spec.description   = 'Built to support all types of checkout integration between Akatus and your application'
  spec.summary       = 'Ruby gem for the Akatus payment system'
  spec.homepage      = 'http://github.com/kauplus/akatus'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport',            '~> 4.0.0'
  spec.add_dependency 'i18n'
  spec.add_dependency 'json'
  spec.add_dependency 'rest-client'

  spec.add_development_dependency 'bundler',      '~> 1.3'
  spec.add_development_dependency 'debugger'
  spec.add_development_dependency 'factory_girl', '~> 4.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec',        '~> 2.14'
end
