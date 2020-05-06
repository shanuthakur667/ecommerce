class Order < ApplicationRecord
  belongs_to :user
  has_one :delivery_detail, dependent: :destroy
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products

  enum status: {not_confirmed: 0, confirmed: 1, cancelled: 2}
end
