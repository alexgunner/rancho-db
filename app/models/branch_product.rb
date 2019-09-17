class BranchProduct < ApplicationRecord
  belongs_to :product
  belongs_to :branch
  has_many :branch_combo_products

  def quantity_sold(since_date, until_date)
    sold = 0
    Order.all.each do |order|
      order.order_items.each do |order_item|
        if order_item.branch_product_id == self.id
          if order_item.created_at > since_date and order_item.created_at < until_date
            sold += 1
          end
        end
      end
    end
    sold
  end

end
