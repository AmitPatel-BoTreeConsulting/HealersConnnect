class PaymentType < ActiveRecord::Base
  attr_accessible :alias, :name

  has_many :registrations
end
