class Course < ActiveRecord::Base
  belongs_to :course_category
  attr_accessible :alias, :description, :donation, :eligibility, :name, :review_donation
end
