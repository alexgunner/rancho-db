class CreateBranchComboProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :branch_combo_products do |t|
      t.references :branch_product, foreign_key: true
      t.references :combo, foreign_key: true

      t.timestamps
    end
  end
end
