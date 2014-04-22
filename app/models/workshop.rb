class Workshop < ActiveRecord::Base
  attr_accessible :assistant_instructor_id, :center_id,
    :course_id, :instructor_id,
    :end_date, :start_date,
    :fees_after_session, :fees_before_session, :fees_on_session,
    :fees_on_rejoining, :fees_date,
    :location, :lat, :long, :contact
  attr_accessible :workshop_sessions_attributes
  validates_presence_of :center_id, :course_id, :instructor_id, :fees_date, :location, :contact
  belongs_to :course
  belongs_to :instructor
  belongs_to :assistant_instructor, class_name: 'Instructor'
  belongs_to :center
  has_many :workshop_sessions, dependent: :delete_all
  has_many :registrations

  accepts_nested_attributes_for :workshop_sessions, allow_destroy: true, reject_if: proc { |att|  att[:session_start].blank? || att[:session_end].blank?}

  attr_accessor :date
end
