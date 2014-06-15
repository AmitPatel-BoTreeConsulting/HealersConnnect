class ActivityPhoto < ActiveRecord::Base
  belongs_to :event
  attr_accessible :event_id, :photo
  paperclip_options = {
        styles: {
            medium: "#{Settings.paperclip.style.medium}>",
            thumb: "#{Settings.paperclip.style.thumb}>",
            activity_small: "#{Settings.paperclip.style.activity.small}>"
        },
        :path => Settings.event_gallery.paperclip.path,
        :url => Settings.event_gallery.paperclip.url
    }

  Paperclip.interpolates :event_id do |image, style|
    image.instance.event_id
  end

  has_attached_file :photo, Paperclip::Attachment.default_options.merge(paperclip_options)
  validates_attachment_content_type :photo, content_type:  /\Aimage\/.*\Z/
end
