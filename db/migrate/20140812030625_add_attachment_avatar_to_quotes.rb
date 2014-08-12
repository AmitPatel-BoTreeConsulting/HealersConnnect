class AddAttachmentAvatarToQuotes < ActiveRecord::Migration
  def self.up
    change_table :quotes do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :quotes, :avatar
  end
end
