class CreateBranchProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :branch_products do |t|
      t.float :sale_cost
      t.references :product, foreign_key: true
      t.references :branch, foreign_key: true

      t.timestamps
    end
  end
end
