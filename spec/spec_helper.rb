require './app'
require 'database_cleaner'

RSpec.configure do |config|
end

DatabaseCleaner.strategy = :truncation