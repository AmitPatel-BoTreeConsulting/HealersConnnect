class EventCategory < ActiveRecord::Base
  attr_accessible :event_alias, :name
  has_many :events
end
