class ProductsController < ApplicationController
  def index
    @products = Product.find_products((params[:search] ? params[:search][:query] : '') , "listing").results
  end

  def show
    @product = Product.find_products(params[:id]).results.try(:first)
  end
end
