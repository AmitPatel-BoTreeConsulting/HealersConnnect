class Instructor < ActiveRecord::Base
  attr_accessible :name, :email, :mobile, :course_ids
  validates_presence_of :name

  validates :email, presence: true, format:  {:with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/}

  has_many :course_instructors
  has_many :courses, through: :course_instructors
  has_many :workshops
  validates :mobile, numericality: { only_integer: true },
            length: { is: 10 }, allow_blank: true,
            format:  {:with => /^[1-9]/}

end
