class Instructor < ActiveRecord::Base
  attr_accessible :name, :email, :mobile
  validates_presence_of :name

  validates :email, presence: true, :format => {:with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/}
end
