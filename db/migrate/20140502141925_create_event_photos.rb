class CreateEventPhotos < ActiveRecord::Migration
  def change
    create_table :event_photos do |t|
      t.integer :event_schedule_id
      t.references :event_schedule

      t.timestamps
    end
    add_index :event_photos, :event_schedule_id
  end
end
