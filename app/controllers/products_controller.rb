class ProductsController < ApplicationController
  
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

  private

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
