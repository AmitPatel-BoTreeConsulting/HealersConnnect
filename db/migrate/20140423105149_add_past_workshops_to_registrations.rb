class AddPastWorkshopsToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :past_workshops, :text
  end
end
