ENV["RAILS_ENV"] = "test"
require "database_cleaner"

require File.expand_path("../dummy/config/environment", __FILE__)
require "support/generator_spec_setup"
require "support/function_definition_helpers"
require "support/aggregate_definition_helpers"

RSpec.configure do |config|
  config.order = "random"
  config.include FunctionDefinitionHelpers
  config.include AggregateDefinitionHelpers
  DatabaseCleaner.strategy = :transaction

  config.around(:each, db: true) do |example|
    DatabaseCleaner.start
    example.run
    DatabaseCleaner.clean
  end

  if defined? ActiveSupport::Testing::Stream
    config.include ActiveSupport::Testing::Stream
  end
end
