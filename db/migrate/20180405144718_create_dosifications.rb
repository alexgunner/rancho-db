class CreateDosifications < ActiveRecord::Migration[5.1]
  def change
    create_table :dosifications do |t|
      t.string :authorization_number
      t.string :dosification_key
      t.date :valid_until
      t.string :activity
      t.references :branch, foreign_key: true

      t.timestamps
    end
  end
end
