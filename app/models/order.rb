class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  enum pay_type: {
    "Check" => 0,
    "Credit Card" => 1,
    "Purchase Order" => 2
  }

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: Order.pay_types.keys
  validates_format_of :email, with: /@/

  def add_line_items_from_cart cart
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
