class EventPhoto < ActiveRecord::Base
  belongs_to :event_schedule
  attr_accessible :event_schedule_id, :photo

  paperclip_options = {
        styles: {
            medium: "#{Settings.paperclip.style.medium}>",
            thumb: "#{Settings.paperclip.style.thumb}>"
        },
        :url => Settings.paperclip.image_path
    }
  has_attached_file :photo, Paperclip::Attachment.default_options.merge(paperclip_options)
  validates_attachment_content_type :photo, content_type:  /\Aimage\/.*\Z/
end
