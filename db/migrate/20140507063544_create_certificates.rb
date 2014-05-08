class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.string :certificate_number
      t.references :user
      t.references :workshop
      t.references :registration

      t.timestamps
    end
    add_index :certificates, :user_id
    add_index :certificates, :workshop_id
    add_index :certificates, :registration_id
  end
end
