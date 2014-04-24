class UserProfile < ActiveRecord::Base
  belongs_to :registration
  belongs_to :user

  attr_accessible :address, :birth_date, :education, :email, :first_name
  attr_accessible :gender, :last_name, :lat, :location, :long, :married
  attr_accessible :middle_name, :mobile, :occupation, :telephone
  validates_presence_of :address, :birth_date, :education, :occupation
  validates_presence_of :first_name, :middle_name, :last_name
  validates :email, presence: true, :format => { :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }
  validates :mobile, numericality: { only_integer: true },
            length: { is: 10 }, allow_blank: true,
            format:  {:with => /^[1-9]/}

  def name
    "#{ first_name } #{ middle_name } #{ last_name }"
  end

  def marital_status
    married? ? 'Married' : 'Unmarried'
  end
end
