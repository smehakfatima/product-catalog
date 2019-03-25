require 'rails_helper'

RSpec.describe Product, type: :model do
  context 'Associations' do
    it 'belongs_to user' do
      association = described_class.reflect_on_association(:user).macro
      expect(association).to eq :belongs_to
    end

    it 'belongs_to category' do
      association = described_class.reflect_on_association(:category).macro
      expect(association).to eq :belongs_to
    end
  end

  context 'Validations' do
    let(:product) { build(:product) }

    it 'creates succesfully' do 
      expect(product).to be_valid
    end

    it 'is not valid without a category' do 
      product.category_id = nil
      expect(product).not_to be_valid
    end

    it 'is not valid without a name' do 
      product.name = nil
      expect(product).not_to be_valid
    end

    it 'is not valid  without a user_id' do
      product.user_id = nil
      expect(product).not_to be_valid
    end

    it 'is not valid  with a name, shorter than 5 characters' do 
      product.name = 'a' * 4
      expect(product).not_to be_valid
    end

    it 'is not valid  with a name, longer than 255 characters' do 
      product.name = 'a' * 260
      expect(product).not_to be_valid
    end

    it 'is not valid without a content' do 
      product.description = nil
      expect(product).not_to be_valid
    end

    it 'is not valid  with a content, shorter than 20 characters' do 
      product.description = 'a' * 10
      expect(product).not_to be_valid
    end

    it 'is not valid  with a content, longer than 1000 characters' do 
      product.description = 'a' * 1050
      expect(product).not_to be_valid
    end
  end  

  context 'Scopes' do
    it 'default_scope orders by descending created_at' do
      first_product = create(:product)
      second_product = create(:product)
      expect(Product.all).to eq [second_product, first_product]
    end

    it 'by_category scope gets products by particular category' do
      category = create(:category)
      create(:product, category_id: category.id)
      create_list(:product, 10)
      products = Product.by_category(category.branch, category.name)
      expect(products.count).to eq 1
      expect(products[0].category.name).to eq category.name
    end

    it 'by_branch scope gets products by particular branch' do
      category = create(:category)
      create(:product, category_id: category.id)
      create_list(:product, 10)
      products = Product.by_branch(category.branch)
      expect(products.count).to eq 1
      expect(products[0].category.branch).to eq category.branch
    end

    it 'search finds a matching product' do
      product = create(:product, name: 'awesome name', description: 'great content ' * 5)
      create_list(:product, 10, name: ('a'..'c' * 2).to_a.shuffle.join)
      expect(Product.search('awesome').count).to eq 1
      expect(Product.search('awesome')[0].id).to eq product.id
      expect(Product.search('great').count).to eq 1
      expect(Product.search('great')[0].id).to eq product.id
    end
  end
end
