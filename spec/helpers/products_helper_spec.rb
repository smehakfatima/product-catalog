require 'rails_helper'

RSpec.describe ProductsHelper, type: :helper do

  context '#create_new_product_partial_path' do
    it "returns a signed_in partial's path" do
      allow(helper).to receive(:user_signed_in?).and_return(true)

      expect(helper.create_new_product_partial_path). to (
        eq 'products/branch/create_new_product/signed_in'
      )
    end

    it "returns a signed_in partial's path" do
      allow(helper).to receive(:user_signed_in?).and_return(false)
      expect(helper.create_new_product_partial_path). to (
        eq 'products/branch/create_new_product/not_signed_in'
      )
    end
  end

  context '#all_categories_button_partial_path' do
    it "returns an all_selected partial's path" do
      controller.params[:category] = ''
      expect(helper.all_categories_button_partial_path).to (
        eq 'products/branch/categories/all_selected'
      )
    end

    it "returns an all_not_selected partial's path" do
      controller.params[:category] = 'category'
      expect(helper.all_categories_button_partial_path).to (
        eq 'products/branch/categories/all_not_selected'
      )
    end
  end

  context '#no_products_partial_path' do
    it "returns a no_products partial's path" do
      assign(:products, [])
      expect(helper.no_products_partial_path).to (
        eq 'products/branch/no_products'
      )
    end

    it "returns an empty partial's path" do
      assign(:products, [1])
      expect(helper.no_products_partial_path).to (
        eq 'shared/empty_partial'
      )
    end
  end
end
