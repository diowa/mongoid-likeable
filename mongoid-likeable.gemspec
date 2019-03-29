# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongoid/likeable/version'

Gem::Specification.new do |spec|
  spec.name        = 'mongoid-likeable'
  spec.version     = Mongoid::Likeable::VERSION
  spec.authors     = ['diowa']
  spec.email       = ['dev@diowa.com']

  spec.summary     = 'Add likes to your Mongoid documents'
  spec.description = spec.summary
  spec.homepage    = 'https://github.com/diowa/mongoid-likeable'
  spec.license     = 'BSD-2-Clause'

  spec.platform    = Gem::Platform::RUBY
  spec.rubyforge_project = 'mongoid-likeable'

  spec.files         = `git ls-files -z -- {CHANGELOG.md,LICENSE,README.md,lib}`.split("\x0")
  spec.require_paths = ['lib']

  spec.add_dependency 'mongoid', '>= 6.0', '< 8'

  spec.add_development_dependency 'activesupport', '~> 5.0', '< 5.2'
  spec.add_development_dependency 'appraisal', '~> 2.2'
  spec.add_development_dependency 'coveralls_reborn', '~> 0.12.0'
  spec.add_development_dependency 'database_cleaner', '~> 1.7'
  spec.add_development_dependency 'm', '~> 1.5'
  spec.add_development_dependency 'minitest', '~> 5.11'
  spec.add_development_dependency 'mocha', '~> 1.8'
  spec.add_development_dependency 'rubocop', '~> 0.66.0'
  spec.add_development_dependency 'simplecov', '~> 0.16.1'
end
