require 'bundler/gem_tasks'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: [:rubocop, :test]

require 'rake/testtask'

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

desc 'Open an irb session preloaded with this library'
task :console do
  sh 'irb -rubygems -r ./lib/mongoid/likeable.rb'
end
