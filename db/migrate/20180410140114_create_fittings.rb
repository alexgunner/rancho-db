class CreateFittings < ActiveRecord::Migration[5.1]
  def change
    create_table :fittings do |t|
      t.string :name
      t.text :description
      t.float :cost

      t.timestamps
    end
  end
end
