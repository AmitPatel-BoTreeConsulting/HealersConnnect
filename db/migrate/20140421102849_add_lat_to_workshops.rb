class AddLatToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :lat, :float
  end
end
