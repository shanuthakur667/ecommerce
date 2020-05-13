class DeliveryDetail < ApplicationRecord
  belongs_to :order
  after_commit :clear_cache

  private

  def clear_cache
    Rails.cache.delete("delivery_detail_#{self.order_id}")
  end
end
