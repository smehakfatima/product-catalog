module ProductsHelper
  def create_new_product_partial_path
    if user_signed_in?
      'products/branch/create_new_product/signed_in'
    else
      'products/branch/create_new_product/not_signed_in'
    end
  end

  def all_categories_button_partial_path
    if params[:category].blank?
      'products/branch/categories/all_selected'
    else
      'products/branch/categories/all_not_selected'
    end
  end

  def no_products_partial_path
  	@products.empty? ? 'products/branch/no_products' : 'shared/empty_partial'
  end
end
