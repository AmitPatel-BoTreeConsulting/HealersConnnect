class CourseCategory < ActiveRecord::Base
  attr_accessible :name, :alias

  validates_presence_of :name
end
