class RemoveEmailIndexToUser < ActiveRecord::Migration
  def up
    change_column :users, :email, :string, default: '', null: true
    remove_index :users, column: :email
    add_index :users, :email
  end

  def down
    change_column :users, :email, :string, default: '', null: false
    remove_index :users, column: :email
    add_index :users, :email, unique: true
  end
end
