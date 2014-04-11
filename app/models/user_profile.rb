class UserProfile < ActiveRecord::Base
  belongs_to :registration
  belongs_to :user
  attr_accessible :address, :birth_date, :education, :email, :first_name, :gender, :last_name, :lat, :location, :long, :married, :middle_name, :mobile, :occupation, :telephone
end
