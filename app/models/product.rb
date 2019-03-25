class Product < ApplicationRecord
	belongs_to :user
  	belongs_to :category

  	default_scope -> { includes(:user).order(created_at: :desc) }

  	scope :by_category, -> (branch, category_name) do 
	  joins(:category).where("categories.name = ? AND categories.branch = ?",category_name, branch)
	  # .where(categories: {name: category_name, branch: branch}) 
	end

	scope :by_branch, -> (branch) do
	  joins(:category).where(categories: {branch: branch}) 
	end

	scope :search, -> (search) do
	  where("products.name ILIKE lower(?) OR products.description ILIKE lower(?)", "%#{search}%", "%#{search}%")
	end
end
