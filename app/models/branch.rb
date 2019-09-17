class Branch < ApplicationRecord
	has_many :branch_products
	has_many :combos
	has_many :orders
	has_many :dosifications
	has_many :users
	has_many :user_branches

	def products_in_branch
		products = []
		self.branch_products.each do |p|
			products.push(p.product)
		end
		products
	end
end
