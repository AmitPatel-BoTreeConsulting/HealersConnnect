class RenameDatabaseColumn < ActiveRecord::Migration
  def self.up
    rename_column :event_photos, :event_id, :event_schedule_id
    remove_index :event_photos, column: :event_id
    add_index :event_photos, :event_schedule_id
  end

  def down
    rename_column :event_photos, :event_schedule_id, :event_id
    add_index :event_photos, :event_id
    remove_index :event_photos, column: :event_schedule_id
  end
end
