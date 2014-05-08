class CreateActivityPhotos < ActiveRecord::Migration
  def change
    create_table :activity_photos do |t|
      t.integer :event_id
      t.references :event

      t.timestamps
    end
    add_index :activity_photos, :event_id
  end
end
