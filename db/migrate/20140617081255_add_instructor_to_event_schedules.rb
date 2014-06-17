class AddInstructorToEventSchedules < ActiveRecord::Migration
  def change
    add_column :event_schedules, :instructor_id, :integer
    add_index :event_schedules, :instructor_id
  end
end
