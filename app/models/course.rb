class Course < ActiveRecord::Base
  belongs_to :course_category
  attr_accessible :alias, :description, :donation, :eligibility, :name, :review_donation,:course_category_id

  attr_accessible :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates_presence_of :name, :course_category_id
  validates_uniqueness_of :name

  has_many :course_instructors
  has_many :instructors, through: :course_instructors

  def update_status(status)
    self.update_attribute(:status, status)
  end

end
