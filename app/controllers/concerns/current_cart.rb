module CurrentCart
  private

  def set_cart
    @cart = Cart.find session[:cart_id]
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

  def clear_current_cart
    begin
      Cart.destroy session[:cart_id]
    rescue
    end
    session[:cart_id] = nil
  end
end
