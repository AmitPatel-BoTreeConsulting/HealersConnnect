class AddLongToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :long, :float
  end
end
