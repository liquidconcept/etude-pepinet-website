require 'rubygems'
require 'spork'

ENV["RAILS_ENV"] ||= 'test'

Spork.prefork do
  # SimpleCov
  require 'simplecov'
  SimpleCov.start('rails') do
    add_filter 'vendor'

    # ignore ActiveAdmin for now
    add_filter 'app/admin'
    add_group 'ActiveAdmin', 'app/admin'
  end

  # Rails
  require File.expand_path("../../config/environment", __FILE__)

  # RSpec
  require 'rspec/rails'
  require 'rspec/autorun'

  RSpec.configure do |config|
    # Filters
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true

    # Mock & fixtures
    config.mock_with :rspec
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false
  end
end

Spork.each_run do
  Dir[Rails.root.join('spec/support/**/*.rb')].each {|f| require f}
end
