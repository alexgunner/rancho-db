class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.string :name
      t.string :description
      t.float :amount

      t.timestamps
    end
  end
end
