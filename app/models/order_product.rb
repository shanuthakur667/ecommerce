class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order
  after_commit :set_prices, on: :create

  private
  def set_prices
    self.product_unit_price = product.unit_price
    self.save
    order.total_price += (product_unit_price * product_quantity)
    order.number_of_item += product_quantity
    order.save
  end
end
