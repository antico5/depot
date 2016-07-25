require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  include ActiveJob::TestHelper

  setup do
    @product = products :one
    @start_order_count = Order.count
  end

  test "buying a product" do
    #Visit home page
    get '/'
    assert_response :success
    assert_select 'h1', /Pragmatic Catalog/

    # Adds a product to the cart
    post '/line_items', params: { product_id: @product.id }, xhr: true
    assert_response :success
    cart = Cart.find session[:cart_id]
    assert_equal 1, cart.line_items.count
    assert_equal @product, cart.line_items.first.product

    # Clicks on checkout
    get '/orders/new'
    assert_response :success
    assert_select 'legend', /Please enter your details/

    # Submit checkout data
    perform_enqueued_jobs do
      post '/orders', params: {
        order: {
          name: 'Armando',
          address: 'Santa Fe Argentina',
          email: 'armando.andini@hotmail.com',
          pay_type: 'Credit Card'
        }
      }
      follow_redirect!
      assert_response :success
      assert_select 'h1', /Catalog/

      cart = Cart.find session[:cart_id]
      assert cart.empty?

      assert @start_order_count + 1, Order.count
      last_order = Order.last
      assert_equal 'Armando', last_order.name
      assert_equal 'Santa Fe Argentina', last_order.address
      assert_equal 'armando.andini@hotmail.com', last_order.email
      assert_equal 'Credit Card', last_order.pay_type
      assert_equal 1, last_order.line_items.count
      assert_equal @product, last_order.line_items.first.product

      mail = ActionMailer::Base.deliveries.last
      assert_equal ['armando.andini@hotmail.com'], mail.to
      assert_equal 'Armando Andini <armando.andini@gmail.com>', mail[:from].value
      assert_equal 'Depot order confirmation.', mail.subject
    end
  end
end
