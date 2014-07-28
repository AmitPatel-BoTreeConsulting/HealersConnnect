class AddOtherDetailsToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :other_details, :text
  end
end
