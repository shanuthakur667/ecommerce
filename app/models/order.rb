class Order < ApplicationRecord
  belongs_to :user
  has_one :delivery_detail, dependent: :destroy
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  has_many :payments

  enum status: {not_confirmed: 0, confirmed: 1, cancelled: 2}

  # def self
    # Order.joins(order_products: :product).where("orders.id = ?", params[:id]).select("products.name AS product_name, order_products.product_unit_price AS unit_price, order_products.product_quantity AS qty, orders.total_price as total_price, orders.number_of_item as total_items")
  # end
end
