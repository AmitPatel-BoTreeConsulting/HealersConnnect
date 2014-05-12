class AddShowOnSliderToWorkshops < ActiveRecord::Migration
  def change
    add_column :workshops, :show_on_slider, :boolean, default: false
  end
end
