class AddLocationToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :location, :string
  end
end
