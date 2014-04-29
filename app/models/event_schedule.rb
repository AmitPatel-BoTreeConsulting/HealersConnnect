class EventSchedule < ActiveRecord::Base
  attr_accessible :center_id, :contact, :donation, :end_date, :event_id, :lat, :long, :notes, :start_date
  belongs_to :center
  belongs_to :event

  has_many :event_eligibilities
  has_many :courses, through: :event_eligibilities

end
