class Instructor < ActiveRecord::Base
  attr_accessible :name, :email, :mobile, :course_ids
  validates_presence_of :name

  validates :email, presence: true, format:  {:with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/}

  has_many :course_instructors
  has_many :courses, through: :course_instructors
  has_many :workshops

end
