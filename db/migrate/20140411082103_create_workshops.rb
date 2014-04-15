class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :workshop_place
      t.string :workshop_dated
      t.string :workshop_instructor
      t.references :registration
      t.references :user

      t.timestamps
    end
    add_index :workshops, :registration_id
    add_index :workshops, :user_id
  end
end
