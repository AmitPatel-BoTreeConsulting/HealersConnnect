class UserProfile < ActiveRecord::Base
  belongs_to :registration
  belongs_to :user

  attr_accessible :address, :birth_date, :education, :email, :first_name, :gender, :last_name, :lat, :location, :long, :married, :middle_name, :mobile, :occupation, :telephone

  validates_presence_of  :address, :birth_date, :education, :occupation, :first_name, :middle_name, :last_name
  validates :email, presence: true, :format => {:with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/}

  def name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def marital_status
    married? ? 'Married' : 'Unmarried'
  end
end
