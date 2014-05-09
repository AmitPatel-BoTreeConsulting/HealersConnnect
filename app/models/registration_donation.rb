class RegistrationDonation < ActiveRecord::Base
  belongs_to :registration
  belongs_to :receiver, class_name: 'User', foreign_key: 'user_id'

  attr_accessible :amount, :description, :received_on, :user_id, :registration_id

  validates_presence_of :user_id, :registration_id, :amount, :description, :received_on
  validates_numericality_of :amount
end
