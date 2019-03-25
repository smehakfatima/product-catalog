class ProductsForBranchService
  def initialize(params)
    @search = params[:search]
    @category = params[:category]
    @branch = params[:branch]
  end

  # get products depending on the request
  def call
    if @category.blank? && @search.blank?
      products = Product.by_branch(@branch).all
    elsif @category.blank? && @search.present?
      products = Product.by_branch(@branch).search(@search)
    elsif @category.present? && @search.blank?
      products = Product.by_category(@branch, @category)
    elsif @category.present? && @search.present?
      products = Product.by_category(@branch, @category).search(@search)
    else
    end
  end

end