class CourseCategory < ActiveRecord::Base
  attr_accessible :name, :alias
  has_many :courses
  validates_presence_of :name
end
