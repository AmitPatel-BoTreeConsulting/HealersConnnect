class AddPastWorkshopsToUserProfile < ActiveRecord::Migration
  def change
    add_column :user_profiles, :past_workshops, :text
  end
end
