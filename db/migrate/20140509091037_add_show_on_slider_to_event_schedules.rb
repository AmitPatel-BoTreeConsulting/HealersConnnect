class AddShowOnSliderToEventSchedules < ActiveRecord::Migration
  def change
    add_column :event_schedules, :show_on_slider, :boolean, default: false
  end
end
