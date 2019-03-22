require "rails_helper"

RSpec.feature "Visit single product", :type => :feature do
  let(:user) { create(:user) }
  let(:product) { create(:product) }

  scenario "User goes to a single product from the home page", js: true do
    product
    visit root_path
    page.find(".single-product-card").click
    expect(page).to have_selector('#single-product-content p', text: product.description)
  end

end