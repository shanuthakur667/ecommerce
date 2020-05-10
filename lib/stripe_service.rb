module StripeService
  Stripe.api_key = ENV['STRIPE_SECRET_kEY']
  def create_or_find_customer user, params, order
    unless user.present? && user.stripe_customer_id.present?
      delivary_detail = order.delivery_detail
      customer = Stripe::Customer.create({
        name: delivary_detail.name,
        description: 'test description',
        email: params[:stripeEmail],
        source: params[:stripeToken],
        address: {line1: delivary_detail.full_address, postal_code: delivary_detail.pin_code, city: delivary_detail.city_name, country: "US"}
      })
      user.stripe_customer_id = customer.id
      user.save
    end
    user.stripe_customer_id
  end

  def create_charge(user, order, params)
    response = {}
    begin
      customer_id = create_or_find_customer(user, params, order)
      response = Stripe::Charge.create(customer: customer_id, amount: (order.total_price.to_i * 100), description: "product buy", currency: SYSREM_DEFAULT_CURRENCY)
    rescue Stripe::StripeError, Stripe::InvalidRequestError, Stripe::CardError => e
      response = {}
    end
    response
  end
end
