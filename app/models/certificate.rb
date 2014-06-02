class Certificate < ActiveRecord::Base
  belongs_to :attendee, class_name: 'User', foreign_key: 'user_id'
  belongs_to :workshop
  belongs_to :registration

  before_create :add_certificate_number

  attr_accessible :certificate_number, :user_id, :workshop_id, :registration_id
  delegate :course, to: :workshop

  validates_presence_of :user_id, :workshop_id, :registration_id

  def add_certificate_number
    self.certificate_number = registration.certificate_number
  end
end
