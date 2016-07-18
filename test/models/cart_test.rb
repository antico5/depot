require 'test_helper'

class CartTest < ActiveSupport::TestCase
  setup do
    @empty_cart = Cart.new
    @filled_cart = Cart.new.tap do |cart|
      cart.add_product products(:one)
      3.times { cart.add_product(products(:two)).save }
    end
  end

  test "cart has one line item per product" do
    @empty_cart.add_product(products(:one)).save
    assert_equal 1, @empty_cart.line_items.count
  end

  test "cart adds up to line item quantity when adding the same product" do
    assert_equal 2, @filled_cart.line_items.count
    assert_equal 3, @filled_cart.line_items.last.quantity
  end

  test "cart calculates total price" do
    assert_equal 35, @filled_cart.total_price
  end
end
