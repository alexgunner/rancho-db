class AddRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :user_role, foreign_key: true
  end
end
