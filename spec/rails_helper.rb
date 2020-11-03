require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require "faker"
require File.expand_path("../config/environment", __dir__)
Dir[Rails.root.join("spec/queries/*.rb")].sort.each { |f| require f }
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
require "database_cleaner"
require "capybara/rspec"
require "capybara/rails"
require "capybara/user_agent"

require "webmock/rspec"
WebMock.disable_net_connect!(allow_localhost: true)

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.infer_base_class_for_anonymous_controllers = false
  config.render_views = true
  config.order = :random

  config.include Capybara::DSL
  config.include Capybara::UserAgent::DSL
end

# Forces all threads to share the same connection
class ActiveRecord::Base
  mattr_accessor :shared_connection
  @@shared_connection = nil

  def self.connection
    @@shared_connection || retrieve_connection
  end
end
ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection

# Change GC paramerets, scrub instance variables on teardown
class ActiveSupport::TestCase
  setup :begin_gc_deferment
  teardown :reconsider_gc_deferment
  teardown :scrub_instance_variables

  @@reserved_ivars = %w[@_implementation @_result @_proxy @_assigns_hash_proxy @_backtrace]
  DEFERRED_GC_THRESHOLD = (ENV["DEFER_GC"] || 1.0).to_f

  @@last_gc_run = Time.now

  def begin_gc_deferment
    GC.disable if DEFERRED_GC_THRESHOLD > 0
  end

  def reconsider_gc_deferment
    if DEFERRED_GC_THRESHOLD > 0 && Time.now - @@last_gc_run >= DEFERRED_GC_THRESHOLD
      GC.enable
      GC.start
      GC.disable

      @@last_gc_run = Time.now
    end
  end

  def scrub_instance_variables
    (instance_variables - @@reserved_ivars).each do |ivar|
      instance_variable_set(ivar, nil)
    end
  end
end
