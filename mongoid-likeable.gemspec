# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'mongoid-likeable'
  s.version     = '5.0.5'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['diowa']
  s.email       = ['dev@diowa.com']
  s.homepage    = 'https://github.com/diowa/mongoid-likeable'
  s.summary     = 'Add likes to your Mongoid documents'
  s.license     = 'BSD-2-Clause'
  s.description = s.summary

  s.rubyforge_project = 'mongoid-likeable'

  s.add_dependency 'mongoid', '~> 4.0'

  s.add_development_dependency 'database_cleaner', '~> 1.4'
  s.add_development_dependency 'rake', '~> 10.4'
  s.add_development_dependency 'delorean', '~> 2.1'
  s.add_development_dependency 'coveralls', '~> 0.7.11'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
