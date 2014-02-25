class Center < ActiveRecord::Base
  belongs_to :foundation
  attr_accessible :address, :email, :lat, :location, :long, :mobile1, :mobile2, :name, :phone1, :phone2
end
