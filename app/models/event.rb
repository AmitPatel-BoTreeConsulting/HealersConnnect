class Event < ActiveRecord::Base
  attr_accessible :description, :event_category_id, :name
  validates_presence_of :name, :description, :event_category_id
  belongs_to :event_category
end
