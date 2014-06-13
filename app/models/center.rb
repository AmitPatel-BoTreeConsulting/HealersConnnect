class Center < ActiveRecord::Base
  belongs_to :foundation
  has_many :user_roles
  has_many :workshops

  
  attr_accessible :name, :address, :location, :lat, :long, :phone1, :phone2, :mobile, :email, :foundation_id
  validates_presence_of :name, :address, :email, :location
  validates :mobile, numericality: { only_integer: true },
            length: { is: 10 }, allow_blank: true,
            format:  {:with => /^[1-9]/}

end
