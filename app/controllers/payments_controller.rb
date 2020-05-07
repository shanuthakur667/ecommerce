class PaymentsController < ApplicationController
  include StripeService
  # before_action :set_order, only: [:pay_now, :pay_on_delivery]

  def pay_now
    @payment = current_user.payments.new(order: @order, amount: @order.total_price, type: Payment.types['pod'], status: Payment.statuses['confirmed'] )
    if @payment.save
      redirect_to order_path(@order)
    else
    end
  end

  def pay_on_delivery
    res = create_charge current_user, Order.last, params
    if res["status"] == "succeeded"
      status = res["status"] == "succeeded" ? Payment.statuses['confirmed'] : Payment.statuses['failed']
      @payment = current_user.payments.new(order: @order, amount: @order.total_price, type: Payment.types['pod'], status: status, call_response: res )
    if @payment.save
    else
      redirect_to order_path(@order)
    end
    end
  end

  private

  def set_order
    @order = Order.find_by(id: params[:id])
  end
end
