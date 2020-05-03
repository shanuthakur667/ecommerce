class ProductsController < ApplicationController
  def index
    @products = Product.search(params[:search] ? params[:search][:query] : '').results
  end
end
