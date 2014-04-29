class CreateEventEligibilities < ActiveRecord::Migration
  def change
    create_table :event_eligibilities do |t|
      t.integer :event_id
      t.integer :course_id

      t.timestamps
    end
  end
end
