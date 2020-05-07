module StripeService
  # extend self

  def create_or_find_customer user, params
    unless user.present? && user.stripe_customer_id.present?
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })
      user.stripe_customer_id = customer.id
      user.save
    end
    user.stripe_customer_id
  end

  def create_charge(user, order, params)
    response = {}
    begin
      customer_id = create_or_find_customer(user, params)
      response = Stripe::Charge.create(customer: customer_id, amount: order.total_price, description: "product buy", currency: SYSREM_DEFAULT_CURRENCY)
    rescue Stripe::StripeError, Stripe::InvalidRequestError, Stripe::CardError => e
      response = {}
    end
    response
  end
end
