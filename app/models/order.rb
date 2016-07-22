class Order < ApplicationRecord
  enum pay_type: {
    "Check" => 0,
    "Credit Card" => 1,
    "Purchase Order" => 2
  }

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: Order.pay_types.keys
  validates_format_of :email, with: /@/
end
