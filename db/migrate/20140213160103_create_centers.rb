class CreateCenters < ActiveRecord::Migration
  def change
    create_table :centers do |t|
      t.string :name
      t.string :location
      t.float :lat
      t.float :long
      t.string :address
      t.string :phone1
      t.string :phone2
      t.string :mobile1
      t.string :mobile2
      t.string :email
      t.references :foundation

      t.timestamps
    end
    add_index :centers, :foundation_id
  end
end
