class CreateEventActivityGalleries < ActiveRecord::Migration
  def change
    create_table :event_activity_galleries do |t|
      t.integer :event_id
      t.references :event

      t.timestamps
    end
    add_index :event_activity_galleries, :event_id
  end
end
