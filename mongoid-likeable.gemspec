# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'mongoid-likeable'
  s.version     = '3.0'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Diowa']
  s.email       = ['dev@diowa.com']
  s.homepage    = 'https://github.com/diowa/mongoid-likeable'
  s.summary     = 'Add likes to your Mongoid documents'
  s.description = s.summary

  s.rubyforge_project = 'mongoid-likeable'

  s.add_dependency 'mongoid', '~> 3.1.0'

  s.add_development_dependency 'database_cleaner', '~> 0.9.1'
  s.add_development_dependency 'rake', '~> 10.0.3'
  s.add_development_dependency 'debugger'
  s.add_development_dependency 'delorean'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
