$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

require 'simplecov'
SimpleCov.start do
  add_filter %w(version.rb)
end

require 'minitest/autorun'
require 'database_cleaner'

require 'mongoid'
require 'mongoid/likeable'

# Suppress non-fatal mongoid messages
Mongo::Logger.logger.level = Logger::FATAL

Dir["#{File.dirname(__FILE__)}/models/*.rb"].each { |f| require f }

Mongoid.connect_to('mongoid-likeable-test')
Mongoid.logger = Logger.new $stdout

DatabaseCleaner[:mongoid].strategy = :truncation
