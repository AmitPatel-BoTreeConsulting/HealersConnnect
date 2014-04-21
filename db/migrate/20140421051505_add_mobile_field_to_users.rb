class AddMobileFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mobile, :string, default: '', unique: true, null: false
  end
end
