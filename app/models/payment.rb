class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :user

  enum status: {pending: 0, confirmed: 1, failed: 2}
  enum type: {pod: 0, pay_now: 1}
  serialize :call_response, JSON

  after_commit :update_order_status, :if => Proc.new {|p| p.confirmed? && p.status_changed?}

  private

  def update_order_status
    order.update_attribute(:status, Order.statuses['confirmed'])
  end
end
