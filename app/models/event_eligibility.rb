class EventEligibility < ActiveRecord::Base
  attr_accessible :course_id, :event_id

  belongs_to :event_schedule
  belongs_to :course
  belongs_to :event_activity_gallery

end
