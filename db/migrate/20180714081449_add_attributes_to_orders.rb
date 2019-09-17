class AddAttributesToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :amount_payed, :float
    add_column :orders, :details, :text
  end
end
