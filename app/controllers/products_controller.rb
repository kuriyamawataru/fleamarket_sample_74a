class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show

    @product = Product.find(params[:id])
    @comments = Comment.where(product_id: params[:id])
  end

  def new
    @product = Product.new
    @product.product_photos.build

    @category_parent_array = ["---"]
    Category.pluck(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
   end

  end

  def create
    product = Product.new(product_params)
    if product.save
      redirect_to root_path
    else
      @category_parent_array = ["---"]
      Category.pluck(ancestry: nil).each do |parent|
        @category_parent_array << parent.name
      end
        render :new
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  
  private
  def product_params
    params.require(:product).permit( :name, :explanation, :category_id, :status, :bear, :brand, :days, :price, product_photos_attributes: [:photo, :_destroy, :id]).merge(exhibitor_user_id: current_user.id)
  end
end
