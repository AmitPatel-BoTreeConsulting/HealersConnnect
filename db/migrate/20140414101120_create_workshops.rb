class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.integer :course_id
      t.integer :instructor_id
      t.integer :assistant_instructor_id
      t.integer :center_id
      t.integer :fees_on_session
      t.integer :fees_before_session
      t.integer :fees_after_session
      t.integer :fees_on_rejoining
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
