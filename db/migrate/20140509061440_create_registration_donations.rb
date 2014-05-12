class CreateRegistrationDonations < ActiveRecord::Migration
  def change
    create_table :registration_donations do |t|
      t.references :registration
      t.references :user
      t.date :received_on
      t.integer :amount
      t.text :description

      t.timestamps
    end
    add_index :registration_donations, :registration_id
    add_index :registration_donations, :user_id
  end
end
