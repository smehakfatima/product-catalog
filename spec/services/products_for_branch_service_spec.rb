require 'rails_helper'
require './app/services/products_for_branch_service.rb'

describe ProductsForBranchService do

  context '#call' do
    let(:not_included_products) { create_list(:product, 2) }
    let(:category) { create(:category, branch: 'hobby', name: 'arts') }
    let(:product) do
      create(:product,
              name: 'a very fun product', 
              category_id: category.id)
    end
    it 'returns products filtered by a branch' do
      not_included_products
      category
      included_products = create_list(:product, 2, category_id: category.id)
      expect(ProductsForBranchService.new({branch: 'hobby'}).call).to(
        match_array included_products
      )
    end

    it 'returns products filtered by a branch and a search input' do
      not_included_products
      category
      included_product = [] << product
      expect(ProductsForBranchService.new({branch: 'hobby', search: 'fun'}).call).to(
        eq included_product
      )
    end

    it 'returns products filtered by a category name' do
      not_included_products
      category
      included_product = [] << product
      expect(ProductsForBranchService.new({branch: 'hobby', category: 'arts'}).call).to(
        eq included_product
      )
    end

    it 'returns products filtered by a category name and a search input' do
      not_included_products
      category
      included_product = [] << product
      expect(ProductsForBranchService.new({name: 'arts', 
                                        search: 'fun', 
                                        branch: 'hobby'}).call).to eq included_product
    end
  end
end