ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'
require 'timecop'
require 'json_spec'
require 'webmock'
require 'webmock/rspec'

ActiveRecord::Migration.maintain_test_schema!

WebMock.disable_net_connect!

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |file| require file }

RSpec.configure do |config|
  config.include JsonSpec::Helpers, type: :request
  config.include ActionDispatch::Integration::RequestHelpers, type: :request
  config.include ActiveSupport::Testing::TimeHelpers

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
