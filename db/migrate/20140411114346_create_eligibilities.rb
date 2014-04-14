class CreateEligibilities < ActiveRecord::Migration
  def change
    create_table :course_instructors do |t|
      t.integer :instructor_id
      t.integer :course_id

      t.timestamps
    end
    add_index :course_instructors, :course_id
    add_index :course_instructors, :instructor_id
    add_index :course_instructors, [:instructor_id, :course_id], unique: true
  end
end
