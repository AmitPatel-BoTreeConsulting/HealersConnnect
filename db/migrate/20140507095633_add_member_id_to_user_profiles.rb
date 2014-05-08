class AddMemberIdToUserProfiles < ActiveRecord::Migration
  def change
    add_column :user_profiles, :member_id, :integer

    # To ensure, Active Record's knowledge of the table structure is current before manipulating data
    UserProfile.reset_column_information

    UserProfile.find_in_batches do |user_profiles_batch|
      user_profiles_batch.each do |user_profile|
        user_profile.add_unique_member_id
      end
    end
  end
end
