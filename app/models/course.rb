class Course < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  belongs_to :course_category
  attr_accessible :alias, :description, :donation, :eligibility, :name, :review_donation,:course_category_id

  attr_accessible :avatar
  paperclip_options = {
      styles: {
          medium: "#{Settings.paperclip.style.medium}>",
          thumb: "#{Settings.paperclip.style.thumb}>"
      },
      :url => Settings.paperclip.image_path
  }

  has_attached_file :avatar, Paperclip::Attachment.default_options.merge(paperclip_options)
  validates_attachment_content_type :avatar, content_type:  /\Aimage\/.*\Z/

  validates_presence_of :name, :course_category_id
  validates_uniqueness_of :name

  has_many :course_instructors
  has_many :instructors, through: :course_instructors
  has_many :workshops
  has_many :event_eligibilities
  has_many :event_schedule, through: :event_eligibilities

  scope :by_alias, ->(aliases) { where(alias: aliases) }

  def update_status(status)
    update_attribute(:status, status)
  end

  def eligibilities
    eligibilities = Course.by_alias(eligibility.split(','))
    eligibility_arrr = eligibilities.inject([]) { |eligibility_arr, course|
      sub_eligibilities = course.eligibilities
      eligibility_arr.push(*sub_eligibilities) unless sub_eligibilities.blank?
      eligibility_arr
    }
    (eligibility_arrr + eligibilities).uniq
  end
end
