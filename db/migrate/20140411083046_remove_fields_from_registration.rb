class RemoveFieldsFromRegistration < ActiveRecord::Migration
  # small hack to bypass the model based error
  # mostly validations and attr_accessible related
  # guides.rubyonrails.org/migrations.html#using-models-in-your-migrations
  class Registration < ActiveRecord::Base
  end

  class UserProfile < ActiveRecord::Base
    attr_accessible :address, :birth_date, :education, :email, :first_name
    attr_accessible :gender, :last_name, :location, :married, :registration_id
    attr_accessible :middle_name, :mobile, :occupation, :telephone, :long, :lat
  end

  class Workshop < ActiveRecord::Base
    attr_accessible :workshop_dated, :workshop_instructor
    attr_accessible :workshop_place, :registration_id
  end

  def up
    # Before droping columns transfers the data to 'UserProfile' and 'Workshop'

    # Only following attributes will be copied to UserProfile from Registration
    user_profile_attr = %w( first_name middle_name last_name birth_date
      education occupation gender married address mobile telephone email
      location long lat registration_id )
    # Only following attributes will be copied to Workshop from Registration
    workshop_attr = %w( workshop_place workshop_dated workshop_instructor
      registration_id )

    # To ensure, Active Record's knowledge of the table structure is current before manipulating data
    Registration.reset_column_information
    UserProfile.reset_column_information
    Workshop.reset_column_information

    # Used Transaction because we need to transfer the all records
    # or none in case of any error
    puts "------------------Starting migration of data from Registration"
    ActiveRecord::Base.transaction do
      Registration.find_in_batches do |records_batch|
        records_batch.each do |registration|
          registration_attr_map = registration.attributes
          # registration_id will be the foreign key in UserProfile and Workshop
          registration_attr_map['registration_id'] = registration_attr_map['id']

          # using create with bang because to stop migration in case
          # any records fails to create
          # to avoid data loss
          UserProfile.create!(registration_attr_map.reject do |k, v|
            user_profile_attr.exclude?(k)
          end)
          Workshop.create!(registration_attr_map.reject do |k, v|
            workshop_attr.exclude?(k)
          end)
        end
      end
    end
    puts "------------------Completed migrating data to Registration"

    # creating FK for user table
    add_column :registrations, :user_id, :integer
    add_index :registrations, :user_id

    remove_column :registrations, :first_name
    remove_column :registrations, :middle_name
    remove_column :registrations, :last_name
    remove_column :registrations, :birth_date
    remove_column :registrations, :education
    remove_column :registrations, :occupation
    remove_column :registrations, :gender
    remove_column :registrations, :married
    remove_column :registrations, :address
    remove_column :registrations, :mobile
    remove_column :registrations, :telephone
    remove_column :registrations, :email
    remove_column :registrations, :location
    remove_column :registrations, :long
    remove_column :registrations, :lat

    remove_column :registrations, :workshop_place
    remove_column :registrations, :workshop_dated
    remove_column :registrations, :workshop_instructor
  end

  def down
    add_column :registrations, :first_name,   :string
    add_column :registrations, :middle_name,  :string
    add_column :registrations, :last_name,    :string
    add_column :registrations, :birth_date,   :date
    add_column :registrations, :education,    :string
    add_column :registrations, :occupation,   :string
    add_column :registrations, :gender,       :string
    add_column :registrations, :married,      :boolean
    add_column :registrations, :address,      :text
    add_column :registrations, :mobile,       :string
    add_column :registrations, :telephone,    :string
    add_column :registrations, :email,        :string
    add_column :registrations, :location,     :string
    add_column :registrations, :long,         :float
    add_column :registrations, :lat,          :float

    add_column :registrations, :workshop_place,       :string
    add_column :registrations, :workshop_dated,       :string
    add_column :registrations, :workshop_instructor,  :string
  end
end
