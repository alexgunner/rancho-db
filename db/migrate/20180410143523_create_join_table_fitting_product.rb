class CreateJoinTableFittingProduct < ActiveRecord::Migration[5.1]
  def change
    create_join_table :fittings, :products do |t|
      # t.index [:fitting_id, :product_id]
      # t.index [:product_id, :fitting_id]
    end
  end
end
