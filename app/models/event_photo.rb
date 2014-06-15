class EventPhoto < ActiveRecord::Base
  belongs_to :event_schedule
  attr_accessible :event_schedule_id, :photo

  paperclip_options = {
        styles: {
            medium: "#{Settings.paperclip.style.medium}>",
            thumb: "#{Settings.paperclip.style.thumb}>"
        },
        :path => Settings.event_schedule_gallery.paperclip.path,
        :url => Settings.event_schedule_gallery.paperclip.url
    }
  has_attached_file :photo, Paperclip::Attachment.default_options.merge(paperclip_options)
  validates_attachment_content_type :photo, content_type:  /\Aimage\/.*\Z/
end
