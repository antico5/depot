require 'test_helper'

class CartTest < ActiveSupport::TestCase
  setup do
    @cart = Cart.new
  end

  test "cart has one line item per product" do
    @cart.add_product(products(:one)).save
    assert_equal 1, @cart.line_items.count
  end

  test "cart adds up to line item quantity when adding the same product" do
    3.times do
      @cart.add_product(products(:two)).save
    end
    assert_equal 1, @cart.line_items.count
    assert_equal 3, @cart.line_items.last.quantity
  end
end
