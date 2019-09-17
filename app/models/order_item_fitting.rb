class OrderItemFitting < ApplicationRecord
  belongs_to :order_item
  belongs_to :fitting
end
