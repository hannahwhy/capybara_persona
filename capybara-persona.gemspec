# -*- encoding: utf-8 -*-
require File.expand_path('../lib/capybara/persona/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Yip"]
  gem.email         = ["yipdw@member.fsf.org"]
  gem.description   = %q{Page object for interacting with Mozilla Persona in automated tests}
  gem.summary       = %q{Mozilla Persona helpers for Capybara}
  gem.homepage      = "https://code.ninjawedding.org/git/capybara-persona.git"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "capybara-persona"
  gem.require_paths = ["lib"]
  gem.version       = Capybara::Persona::VERSION

  gem.add_dependency 'capybara'

  gem.add_development_dependency 'aws-s3'
  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'json'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'sinatra'
end
