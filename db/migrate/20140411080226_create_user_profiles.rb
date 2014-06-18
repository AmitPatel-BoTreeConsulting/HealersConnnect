class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :birth_date
      t.string :education
      t.string :occupation
      t.string :gender
      t.boolean :married
      t.text :address
      t.string :mobile
      t.string :telephone
      t.string :email
      t.string :location
      t.float :long
      t.float :lat
      t.references :registration
      t.references :user

      t.timestamps
    end
    add_index :user_profiles, :registration_id
    add_index :user_profiles, :user_id
  end
end
