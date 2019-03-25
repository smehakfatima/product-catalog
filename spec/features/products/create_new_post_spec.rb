require "rails_helper"

RSpec.feature "Create a new product", :type => :feature do
  let(:user) { create(:user) }
  before(:each) { sign_in user }

  shared_examples 'user creates a new product' do |branch|
    scenario 'successfully' do
      create(:category, name: 'category', branch: branch)
      visit send("#{branch}_products_path")
      find('.new-product-button').click
      fill_in 'product[name]', with: 'a' * 20
      fill_in 'product[description]', with: 'a' * 20
      select 'category', from: 'product[category_id]' 
      click_on 'Create a product'
      expect(page).to have_selector('h3', text: 'a' * 20)
    end
  end

  include_examples 'user creates a new product', 'electronics'
  include_examples 'user creates a new product', 'books'
  include_examples 'user creates a new product', 'accessories'
end