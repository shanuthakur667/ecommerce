class CartController < ApplicationController
  def index
    if session["cart"]["products"]
      @products = Product.includes(:category, :company).where(id: session["cart"]["products"].uniq)
      @quan = Hash.new
      session["cart"]["products"].each{|product| @quan[product] = (@quan[product] || 0) + 1}
    else
      @products = []
    end
  end

  def add
    session["cart"] ||={}
    products = session["cart"]["products"]
    (1..params[:quantity].to_i).each do |quan|
      if (session["cart"]["products"] && session["cart"] != {})
        session["cart"]["products"] << params["product_id"]
      else
        session["cart"]["products"] = Array(params["product_id"])
      end
    end
    respond_to do |format|
      format.json { render json: cart_session.build_json }
      format.html { redirect_to cart_index_path }
    end
  end

  def delete
    session[:cart] ||={}
    products = session[:cart][:products]
    id = params[:id]
    all = params[:all]
    unless id.blank?
      unless all.blank?
        products.delete(params['id'])
      else
        products.delete_at(products.index(id) || products.length)
      end
    else
      products.delete
    end
    respond_to do |format|
      format.json { render json: cart_session.build_json }
      format.html { redirect_to cart_index_path }
    end
  end
end
