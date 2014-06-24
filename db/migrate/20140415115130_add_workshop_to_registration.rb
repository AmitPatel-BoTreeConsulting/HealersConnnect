class AddWorkshopToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :workshop_id, :integer
    add_index :registrations, :workshop_id
  end
end
