class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.integer :role_id
      t.integer :user_id
      t.integer :center_id

      t.timestamps
    end
    add_index :user_roles, :role_id
    add_index :user_roles, :user_id
    add_index :user_roles, :center_id
    add_index :user_roles, [:role_id, :user_id, :center_id], unique: true
  end
end
