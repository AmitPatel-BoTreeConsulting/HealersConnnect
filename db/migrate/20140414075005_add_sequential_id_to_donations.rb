class AddSequentialIdToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :sequential_id, :integer
  end
end
