class Registration < ActiveRecord::Base
  attr_accessible :first_name, :middle_name, :last_name, :birth_date, :education, :occupation, :gender, :married,
                  :address, :mobile,  :telephone, :email, :location, :long, :lat, :workshop_place, :workshop_dated,
                  :workshop_instructor, :payment_type_id

  validates_presence_of :first_name, :middle_name, :last_name, :birth_date, :education, :occupation, :gender, :married,
                        :address, :workshop_place, :workshop_dated, :workshop_instructor

  validates :email, presence: true, :format => {:with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/}

  belongs_to :payment_type

  def name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def marital_status
    married? ? 'Married' : 'Unmarried'
  end

end
