class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :donar_name
      t.string :donar_email
      t.string :receipt_number
      t.integer :donation_type, :limit => 1
      t.text :description
      t.references :center
      t.references :user
      t.references :received_by_user
      t.float :amount

      t.timestamps
    end
    add_index :donations, :donation_type
    add_index :donations, :center_id
    add_index :donations, :user_id
    add_index :donations, :received_by_user_id
  end
end
