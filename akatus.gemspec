# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'akatus/version'

Gem::Specification.new do |spec|
  spec.name          = "akatus"
  spec.version       = Akatus::VERSION
  spec.authors       = ["Kauplus"]
  spec.email         = ["tech@kauplus.com.br"]
  spec.description   = %q{A gem foi criada para suportar todas as integrações de pagamentos da Akatus.}
  spec.summary       = %q{Gem de integração com o meio de pagamentos Akatus}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
