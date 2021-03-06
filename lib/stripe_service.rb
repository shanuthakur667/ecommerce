module StripeService
  Stripe.api_key = ENV['STRIPE_SECRET_kEY']
  def create_or_find_customer user, params, order_id
    unless user.present? && user.stripe_customer_id.present?
      delivery_detail = Order.delivery_detail_data order_id
      customer = Stripe::Customer.create({
        name: delivery_detail['name'],
        description: 'test description',
        email: params[:stripeEmail],
        source: params[:stripeToken],
        address: {line1: delivery_detail['full_address'], postal_code: delivery_detail['pin_code'], city: delivery_detail['city_name'], country: "US"}
      })
      user.stripe_customer_id = customer.id
      user.save
    end
    user.stripe_customer_id
  end

  def create_charge(user, order, params)
    response = {}
    begin
      customer_id = create_or_find_customer(user, params, order.id)
      response = Stripe::Charge.create(customer: customer_id, amount: (order.total_price.to_i * 100), description: "product buy", currency: SYSTEM_DEFAULT_CURRENCY)
    rescue Stripe::StripeError, Stripe::InvalidRequestError, Stripe::CardError => e
      response = {}
    end
    response
  end
end
