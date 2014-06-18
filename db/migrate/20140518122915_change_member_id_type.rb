class ChangeMemberIdType < ActiveRecord::Migration
  def up
    change_column :users, :member_id, :string
    change_column :user_profiles, :member_id, :string
  end

  def down
    change_column :users, :member_id, :integer
    change_column :user_profiles, :member_id, :integer
  end
end
