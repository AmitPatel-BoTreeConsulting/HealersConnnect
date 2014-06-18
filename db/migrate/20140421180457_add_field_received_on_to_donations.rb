class AddFieldReceivedOnToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :received_on, :datetime
  end
end
