class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :birth_date
      t.string :gender
      t.boolean :married
      t.string :education
      t.string :occupation
      t.text :address
      t.string :mobile
      t.string :telephone
      t.string :email
      t.string :location
      t.float :lat
      t.float :long
      t.string :workshop_place
      t.string :workshop_dated
      t.string :workshop_instructor
      t.references :payment_type

      t.timestamps
    end
  end
end
