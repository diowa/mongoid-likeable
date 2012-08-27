$:.unshift(File.expand_path("../../lib", __FILE__))

require 'minitest/autorun'
require 'database_cleaner'

require 'mongoid'

Mongoid.connect_to('mongoid-voteable-test')
Mongoid.logger = Logger.new $stdout

DatabaseCleaner.orm = 'mongoid'
DatabaseCleaner.strategy = :truncation
