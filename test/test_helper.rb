ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def add_test_product_to_cart!
    post line_items_url, params: { product_id: products(:one).id }
  end

  def login_admin_user!
    user = users(:one)
    post login_url, params: { name: user.name, password: 'secret' }
  end

  def logout_user!
    delete logout_url
  end

  class ActionDispatch::IntegrationTest
    def setup
      login_admin_user!
    end
  end
end
