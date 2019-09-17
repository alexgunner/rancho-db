class CreateBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :branches do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :city

      t.timestamps
    end
  end
end
