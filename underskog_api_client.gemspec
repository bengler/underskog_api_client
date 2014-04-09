# encoding: utf-8
require File.expand_path('../lib/underskog/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'activesupport', ['>= 2.3.9', '< 4']
  gem.add_dependency 'faraday', '0.8'
  gem.add_dependency 'multi_json', '~> 1.3'
  gem.add_dependency 'simple_oauth', '~> 0.1.6'
  gem.add_development_dependency 'json'
  gem.add_development_dependency 'maruku'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'yard'
  gem.authors = ["skogsmaskin"]
  gem.description = %q{A Ruby wrapper for the Underskog API.}
  gem.email = ['pk@bengler.no']
  gem.executables = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gem.files = `git ls-files`.split("\n")
  gem.homepage = 'https://github.com/bengler/underskog_api_client'
  gem.name = 'underskog_api_client'
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new('>= 1.3.6')
  gem.summary = %q{Underskog API wrapper}
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version = Underskog::Version.to_s
end
