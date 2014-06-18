class AddFeesDateToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :fees_date, :datetime
  end
end
