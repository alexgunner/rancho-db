class Fitting < ApplicationRecord
	has_and_belongs_to_many :products
	has_and_belongs_to_many :combos
	has_many :order_item_fittings
end
