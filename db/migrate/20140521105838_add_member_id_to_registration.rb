class AddMemberIdToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :member_id, :string
    add_index :registrations, :member_id
  end
end
