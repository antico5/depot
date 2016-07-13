class Product < ApplicationRecord
  has_many :line_items
  before_destroy :ensure_not_referenced

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true
  validates :image_url, allow_blank: true,
    format: { with: /\.(gif|jpg|png)\Z/, message: 'must be PNG, JPG or GIF' }

  def self.latest
    order(:updated_at).last
  end

  private

  def ensure_not_referenced
    unless line_items.empty?
      errors.add :base, 'line items not empty'
      throw :abort
    end
  end
end

