class EventCategory < ActiveRecord::Base
  attr_accessible :alias, :name
  has_many :events

  scope :except_activity, where("alias <> 'activity'")
end
