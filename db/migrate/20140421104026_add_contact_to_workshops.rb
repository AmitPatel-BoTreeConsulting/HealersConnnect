class AddContactToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :contact, :string
  end
end
