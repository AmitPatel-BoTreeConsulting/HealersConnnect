class Event < ActiveRecord::Base
  attr_accessible :description, :event_category_id, :name, :avatar, :event_category_id
  validates_presence_of :name, :description, :event_category_id

  paperclip_options = {
      styles: {
          medium: "#{Settings.paperclip.style.medium}>",
          thumb: "#{Settings.paperclip.style.thumb}>"
      },
      :path => Settings.events.paperclip.path,
      :url => Settings.events.paperclip.url
  }

  Paperclip.interpolates :id do |image, style|
    image.instance.id
  end

  has_attached_file :avatar, Paperclip::Attachment.default_options.merge(paperclip_options)
  validates_attachment_content_type :avatar, content_type:  /\Aimage\/.*\Z/

  scope :events_without_activity, -> { joins(:event_category).where("event_categories.alias !='activity'") }

  scope :events_with_only_activity, -> { joins(:event_category).where("event_categories.alias ='activity'") }
  belongs_to :event_category
  has_many :event_schedules, dependent: :destroy
  has_many :activity_photos, dependent: :destroy
end
