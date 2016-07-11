require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "attributes shouldn't be empty" do
    p = Product.new
    assert p.invalid?
    [:title,:description,:price,:image_url].each do |attr|
      assert p.errors[attr].any?
    end
  end

  test "product price must be positive" do
    p = products(:one)
    p.update price: -1
    assert p.errors[:price].any?
    p.update price: 1
    assert p.errors[:price].empty?
  end

  test "product image_url should be of valid format" do
    p = products(:one)
    p.update image_url: "invalid_format.avi"
    assert p.errors[:image_url].any?
    p.update image_url: "valid.jpg"
    assert p.errors[:image_url].empty?
  end
end
