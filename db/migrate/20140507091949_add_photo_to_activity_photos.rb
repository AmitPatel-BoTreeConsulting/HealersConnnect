class AddPhotoToActivityPhotos < ActiveRecord::Migration
  def self.up
    change_table :activity_photos do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :activity_photos, :photo
  end
end
