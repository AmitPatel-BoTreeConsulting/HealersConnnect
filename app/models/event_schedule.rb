class EventSchedule < ActiveRecord::Base
  attr_accessible :center_id, :contact, :donation, :end_date, :event_id, :lat, :long, :notes, :start_date, :location, :course_ids, :instructor_id
  belongs_to :center
  belongs_to :event
  belongs_to :instructor

  validates_presence_of :center_id, :event_id, :location, :start_date, :end_date
  has_many :event_eligibilities, dependent: :delete_all
  has_many :courses, through: :event_eligibilities
  has_many :event_photos, dependent: :destroy

  scope :upcoming_events, lambda { where("start_date >= ?", Date.today).order(:start_date) }
  scope :show_on_slider, upcoming_events.where(show_on_slider: true)
  scope :for_center, ->(centers) { where(center_id: centers) }

  def event_eligibility_names
    event_eligibilities.inject([]) { |result, eligibility| result << eligibility.course.name }
  end

  private

  # Prepare array of upcoming events for home slider
  def self.upcoming_events_for_slider
    events = []
    show_on_slider.each do |event|
      upcoming_event_hash = {}
      upcoming_event_hash[:image] = Rails.application.routes.url_helpers.website_activity_image_path(style: :original, id: event.event.id, filename: event.event.avatar_file_name) if event.event.avatar_file_name.present?
      upcoming_event_hash[:name] = event.event.name
      upcoming_event_hash[:description] = event.event.description
      upcoming_event_hash[:id] = event.event_id
      upcoming_event_hash[:url] = Rails.application.routes.url_helpers.website_home_path(event.event_id)
      upcoming_event_hash[:show_on_slider] = event.show_on_slider
      events << upcoming_event_hash
    end
    events
  end

  def self.upcoming_events
    includes(:event).where('start_date >= ?', Date.today).order(:start_date)
  end

end
