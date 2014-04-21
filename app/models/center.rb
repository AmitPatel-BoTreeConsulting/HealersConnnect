class Center < ActiveRecord::Base
  belongs_to :foundation
  has_many :user_roles
  has_many :workshops

  attr_accessible :name, :address, :location, :lat, :long, :phone1, :phone2, :mobile, :email, :foundation_id
  validates_presence_of :name, :address, :email, :location
  validates :mobile, phone: {possible: true, types: [:mobile]}

end
