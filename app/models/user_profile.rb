class UserProfile < ActiveRecord::Base
  belongs_to :registration
  belongs_to :user

  after_create :add_unique_member_id

  RANDOM_MEMBER_ID_RANGE = 1000..9999

  attr_accessible :address, :birth_date, :education, :email, :first_name
  attr_accessible :gender, :last_name, :lat, :location, :long, :married
  attr_accessible :middle_name, :mobile, :occupation, :telephone, :member_id

  validates_uniqueness_of :member_id
  validates_presence_of :address, :birth_date, :education, :occupation
  validates_presence_of :first_name, :middle_name, :last_name
  validates :email, :format => { :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }
  validates :mobile, numericality: { only_integer: true },
            length: { is: 10 }, allow_blank: true,
            format:  {:with => /^[1-9]/}

  def name
    "#{ first_name } #{ middle_name } #{ last_name }"
  end

  def marital_status
    married? ? 'Married' : 'Unmarried'
  end

  def add_unique_member_id
    update_attribute(:member_id, generate_member_id)
  end

  private

  def generate_member_id
    first_part = first_name.downcase[0..3]
    second_part = birth_date.strftime('%d%m')

    while UserProfile.find_by_member_id(first_part + second_part)
      second_part = rand(RANDOM_MEMBER_ID_RANGE).to_s
    end
    first_part + second_part
  end
end
