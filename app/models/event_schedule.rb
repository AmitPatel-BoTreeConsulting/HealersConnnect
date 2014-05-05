class EventSchedule < ActiveRecord::Base
  attr_accessible :center_id, :contact, :donation, :end_date, :event_id, :lat, :long, :notes, :start_date, :location, :course_ids
  belongs_to :center
  belongs_to :event

  validates_presence_of :center_id, :event_id, :location, :start_date, :end_date
  has_many :event_eligibilities, dependent: :delete_all
  has_many :courses, through: :event_eligibilities
  has_many :event_activity_galleries

end
