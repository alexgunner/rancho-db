class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.integer :branch_product_id
      t.integer :combo_id
      t.integer :quantity

      t.timestamps
    end
  end
end
