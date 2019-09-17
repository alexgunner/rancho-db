class AddFieldToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :order_state, :boolean
  end
end
