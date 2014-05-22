class SwapRelationBetweenRegistrationAndUserProfile < ActiveRecord::Migration
  def up
    remove_column :user_profiles, :registration_id
    remove_column :registrations, :member_id
    change_table :registrations do |t|
      t.references :user_profile
    end
    add_index :registrations, [:user_profile_id]
  end

  def down
    add_column :user_profiles, :registration_id, :integer
    remove_column :registrations, :user_profile_id
  end
end
