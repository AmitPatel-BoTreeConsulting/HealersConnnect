class AddAvatarToEventActivityGalleries < ActiveRecord::Migration
  def self.up
    change_table :event_activity_galleries do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :event_activity_galleries, :avatar
  end
end
