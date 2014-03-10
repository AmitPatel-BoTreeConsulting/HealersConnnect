class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :alias
      t.string :eligibility
      t.text :description
      t.references :course_category
      t.integer :donation
      t.integer :review_donation

      t.timestamps
    end
    add_index :courses, :course_category_id
  end
end
