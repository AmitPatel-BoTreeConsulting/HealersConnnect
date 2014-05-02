class EventCategory < ActiveRecord::Base
  attr_accessible :alias, :name
  has_many :events
end
