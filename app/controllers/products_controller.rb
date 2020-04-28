class ProductsController < ApplicationController
  def index
    Product.search(params[:search] ? params[:search][:query] : '').results
  end
end
