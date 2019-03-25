class ProductsController < ApplicationController
  before_action :redirect_if_not_signed_in, only: [:new]
  def show
    @product = Product.find(params[:id])
  end

  def electronics
    products_for_branch(params[:action])
  end

  def books
    products_for_branch(params[:action])
  end

  def accessories
    products_for_branch(params[:action])
  end

  def new
    @branch = params[:branch]
    @categories = Category.where(branch: @branch)
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save 
      redirect_to product_path(@product) 
    else
      redirect_to root_path
    end
  end


  private

  def product_params
    params.require(:product).permit(:description, :name, :category_id)
                         .merge(user_id: current_user.id)
  end

	def products_for_branch(branch)
	  @categories = Category.where(branch: branch)
	  @products = get_products.paginate(page: params[:page])
	end

	def get_products
	  ProductsForBranchService.new({
      search: params[:search],
      category: params[:category],
      branch: params[:action]
    }).call
	end
end
