class WorkshopSession < ActiveRecord::Base
  belongs_to :workshop
  attr_accessible :session_end, :session_start, :workshop_id
end
