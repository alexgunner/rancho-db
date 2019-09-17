class CreateJoinTableFittingCombo < ActiveRecord::Migration[5.1]
  def change
    create_join_table :fittings, :combos do |t|
      # t.index [:fitting_id, :combo_id]
      # t.index [:combo_id, :fitting_id]
    end
  end
end
