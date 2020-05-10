class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :user

  enum status: {pending: 0, confirmed: 1, failed: 2}
  enum type: {pay_on_delivery: 0, pay_now: 1}
  serialize :call_response, JSON

  after_save :change_order_status, if: Proc.new {|p| p.confirmed? && p.previous_changes.keys.include?("status")}

  private

  def change_order_status
    order.update_attribute(:status, Order.statuses['confirmed'])
  end

end
