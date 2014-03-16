class AddActiveToRegistrations < ActiveRecord::Migration

	def up
    add_column :registrations, :active, :boolean, default: true
		Registration.reset_column_information
		Registration.update_all(active: true)
  end

  def down
		remove_column :registrations, :active
  end

end
