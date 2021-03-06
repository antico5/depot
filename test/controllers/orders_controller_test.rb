require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should get new" do
    add_test_product_to_cart!
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      add_test_product_to_cart!
      post orders_url, params: { order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type } }
    end

    assert_redirected_to store_index_url
    follow_redirect!
    assert_select "#notice", /Thank you/
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { address: @order.address, email: @order.email, name: @order.name, pay_type: @order.pay_type } }
    assert_redirected_to order_url(@order)
  end

  test "should send email when ship_date is updated" do
    perform_enqueued_jobs do
      patch order_url(@order), params: { order: { ship_date: DateTime.now } }
      mail = ActionMailer::Base.deliveries.last
      assert_equal [@order.email], mail.to
      assert_match /shipped/, mail.subject
    end
  end


  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
