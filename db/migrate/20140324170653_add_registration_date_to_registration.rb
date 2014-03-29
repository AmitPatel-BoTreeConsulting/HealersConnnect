class AddRegistrationDateToRegistration < ActiveRecord::Migration
  def up
    add_column :registrations, :registration_date, :date
    Registration.reset_column_information
    Registration.where(registration_date: nil).update_all('registration_date = created_at')
  end

  def down
    remove_column :registrations, :registration_date
  end
end
