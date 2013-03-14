$:.unshift(File.expand_path("../../lib", __FILE__))

require 'coveralls'
Coveralls.wear!

require 'minitest/autorun'
require 'database_cleaner'

require 'mongoid'
require 'mongoid/likeable'

require 'debugger'
if defined?(Debugger)
  ::Debugger.settings[:autoeval] = true if ::Debugger.respond_to?(:settings)
end

Dir["#{File.dirname(__FILE__)}/models/*.rb"].each { |f| require f }

Mongoid.connect_to('mongoid-likeable-test')
Mongoid.logger = Logger.new $stdout

DatabaseCleaner.orm = 'mongoid'
DatabaseCleaner.strategy = :truncation
