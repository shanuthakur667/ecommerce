class OrdersController < ApplicationController
  include Calculator
  before_action :set_order, only: [:show, :set_delivery_detail]

  def create
    @order = current_user.orders.create
    product_wise_quantity
    @quan.each do |product_id, quantity|
      @order.order_products.create(product_id: product_id.to_i, product_quantity: quantity)
    end
    redirect_to order_path(@order)
  end

  def show
    @delivery_detail = @order.delivery_detail
    @delivery_detail = @order.build_delivery_detail unless @delivery_detail
  end

  def set_delivery_detail
    @delivery_detail = @order.build_delivery_detail(delivery_detail_attributes)
    @delivery_detail.save
    redirect_to order_path(@order)
  end
  private

  def delivery_detail_attributes
    params.require(:delivery_detail).permit(:full_address, :city_name, :email, :name, :phone, :pin_code)
  end

  def set_order
    @order = Order.find_by(id: params[:id])
  end
end
