class EventCategory < ActiveRecord::Base
  attr_accessible :event_alias, :name
  has_many :events

  scope :except_activity, where("event_alias <> 'activity'")
end
