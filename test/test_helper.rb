$:.unshift(File.expand_path("../../lib", __FILE__))

if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

require 'minitest/autorun'
require 'database_cleaner'

require 'mongoid'
require 'mongoid/likeable'

Dir["#{File.dirname(__FILE__)}/models/*.rb"].each { |f| require f }

Mongoid.connect_to('mongoid-likeable-test')
Mongoid.logger = Logger.new $stdout

DatabaseCleaner.orm = 'mongoid'
DatabaseCleaner.strategy = :truncation
