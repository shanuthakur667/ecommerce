class PaymentsController < ApplicationController
  include StripeService
  before_action :set_order, only: [:pay_now, :pay_on_delivery]

  def pay_now
    res = create_charge current_user, @order, params
    status = res["status"] == "succeeded" ? Payment.statuses['confirmed'] : Payment.statuses['failed']
    @payment = current_user.payments.new(order: @order, amount: @order.total_price, payment_type: Payment.types['pay_now'], status: status, call_response: res )
    if @payment.save
      redirect_to order_path(@order)
    else
      redirect_to order_path(@order)
    end
  end

  def pay_on_delivery
    @payment = current_user.payments.new(order: @order, amount: @order.total_price, payment_type: Payment.types['pay_on_delivery'], status: Payment.statuses['confirmed'] )
    if @payment.save
      redirect_to order_path(@order)
    else
    end
  end

  private

  def set_order
    @order = Order.find_by(id: params[:order_id])
  end
end
