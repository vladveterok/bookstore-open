ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
require 'ffaker'
require 'aasm/rspec'

SimpleCov.start 'rails' do
  minimum_coverage 90
  add_filter ['app/jobs', 'app/mailers', 'app/channels', 'app/admin/admin_user', 'app/admin/dashboard']
end

require File.expand_path('../config/environment', __dir__)
Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
require 'support/factory_bot'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

OmniAuth.config.test_mode = true

RSpec.configure do |config|
  config.include Shoulda::Matchers::ActiveModel, type: :model
  config.include Shoulda::Matchers::ActiveRecord, type: :model
  config.include Shoulda::Matchers::ActiveModel, type: :model
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::IntegrationHelpers, type: :feature
  config.include Devise::Test::IntegrationHelpers, type: :request
  config.include CarrierWave::Test::Matchers

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end
