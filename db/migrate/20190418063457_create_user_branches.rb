class CreateUserBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :user_branches do |t|
      t.references :user, foreign_key: true
      t.references :branch, foreign_key: true

      t.timestamps
    end
  end
end
