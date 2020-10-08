require 'simplecov'
SimpleCov.start do
  add_group 'Resources', 'lib/gentem/resources'
end

require "bundler/setup"
require 'rspec/its'
require 'webmock/rspec'
require 'byebug'
require "gentem"

Dir['spec/support/**/*.rb'].each { |f| require f.gsub(/^spec\//, '') }

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
