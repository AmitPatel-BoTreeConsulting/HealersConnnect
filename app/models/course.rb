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
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates_presence_of :name, :course_category_id
  validates_uniqueness_of :name

  def update_status(status)
    self.update_attribute(:status, status)
  end

end
