module Calculator
  extend ActiveSupport::Concern
  def product_wise_quantity
    @quan = Hash.new
    session["cart"]["products"].each{|product| @quan[product] = (@quan[product] || 0) + 1}
  end
end
