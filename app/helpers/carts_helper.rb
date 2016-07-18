module CartsHelper
  def format_line_item line_item
    "%i x %s" % [line_item.quantity, line_item.product.title]
  end
end
