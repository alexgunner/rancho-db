class AddTotalAmountToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :total_order_amount, :float
  end
end
