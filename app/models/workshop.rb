class Workshop < ActiveRecord::Base
  attr_accessible :assistant_instructor_id, :center_id,
    :course_id, :instructor_id,
    :end_date, :start_date,
    :fees_after_session, :fees_before_session, :fees_on_session,
    :fees_on_rejoining

  validates_presence_of :center_id, :course_id, :instructor_id
  belongs_to :course
  belongs_to :instructor
  belongs_to :assistant_instructor, class_name: 'Instructor'
  belongs_to :center
  has_many :workshop_sessions
  has_many :registrations
  has_many :session_start, dependent: :delete_all
  has_many :session_end, dependent: :delete_all
  attr_accessible :session_start_attributes
  attr_accessible :session_end_attributes

  accepts_nested_attributes_for :session_start, allow_destroy: true
  accepts_nested_attributes_for :session_end, allow_destroy: true
end
