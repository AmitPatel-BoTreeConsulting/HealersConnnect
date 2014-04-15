class Workshop < ActiveRecord::Base
  attr_accessible :assistant_instructor_id, :center_id, :course_id, :end_date, :fees_after_session, :fees_before_session, :fees_on_rejoining, :fees_on_session, :instructor_id, :start_date

  belongs_to :course
  has_one :instructor
  has_one :assistant_instructor , class: 'Instructor'
  belongs_to :center
  has_many :workshop_sessions

end
