require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  setup do
    @order = orders :one
  end

  test "received" do
    mail = OrderMailer.received @order
    assert_equal "Depot order confirmation.", mail.subject
    assert_equal [@order.email], mail.to
  end

  test "shipped" do
    mail = OrderMailer.shipped @order
    assert_equal "Depot order has been shipped.", mail.subject
    assert_equal [@order.email], mail.to
    assert_match "Hi", mail.body.encoded
  end

end
