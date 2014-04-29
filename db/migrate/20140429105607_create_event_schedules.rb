class CreateEventSchedules < ActiveRecord::Migration
  def change
    create_table :event_schedules do |t|
      t.integer :event_id
      t.integer :center_id
      t.float :lat
      t.float :long
      t.datetime :start_date
      t.datetime :end_date
      t.string :contact
      t.integer :donation
      t.text :notes

      t.timestamps
    end
  end
end
