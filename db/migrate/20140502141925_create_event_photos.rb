class CreateEventPhotos < ActiveRecord::Migration
  def change
    create_table :event_photos do |t|
      t.integer :event_id
      t.references :event

      t.timestamps
    end
    add_index :event_photos, :event_id
  end
end