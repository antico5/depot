class OrdersController < ApplicationController
  include  CurrentCart
  before_action :set_cart, only: [:new, :create]
  before_action :check_cart_not_empty, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  skip_before_action :authorize!, only: [:new,:create]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart @cart

    respond_to do |format|
      if @order.save
        clear_current_cart
        OrderMailer.received(@order).deliver_later
        format.html { redirect_to store_index_url, notice: t('.thanks_you')}
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        send_shipped_mail(@order) if @order.previous_changes[:ship_date]
        format.html { redirect_to @order, notice: t('.order_updated') }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: t('.order_destroyed') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type, :ship_date)
    end

    def check_cart_not_empty
      if @cart.empty?
        redirect_to store_index_url, notice: t('.cart_is_empty')
      end
    end

    def send_shipped_mail order
      OrderMailer.shipped(order).deliver_later
    end
end
