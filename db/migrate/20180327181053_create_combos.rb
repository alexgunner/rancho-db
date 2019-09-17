class CreateCombos < ActiveRecord::Migration[5.1]
  def change
    create_table :combos do |t|
      t.string :name
      t.text :description
      t.float :sale_cost
      t.references :branch, foreign_key: true

      t.timestamps
    end
  end
end
