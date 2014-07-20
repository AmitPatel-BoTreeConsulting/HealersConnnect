class Workshop < ActiveRecord::Base
  attr_accessible :assistant_instructor_id, :center_id,
    :course_id, :instructor_id,
    :end_date, :start_date,
    :fees_after_session, :fees_before_session, :fees_on_session,
    :fees_on_rejoining, :fees_date,
    :location, :lat, :long, :contact
  attr_accessible :workshop_sessions_attributes

  belongs_to :course
  belongs_to :instructor
  belongs_to :assistant_instructor, class_name: 'Instructor'
  belongs_to :center
  has_many :workshop_sessions, dependent: :destroy
  has_many :registrations
  has_many :certificates

  accepts_nested_attributes_for :workshop_sessions, allow_destroy: true, reject_if: proc { |att| att[:session_start].blank? || att[:session_end].blank? || !att[:session_start].instance_of?(DateTime)}

  validates_presence_of :center_id, :course_id, :instructor_id, :fees_date, :location, :contact
  validates_presence_of :fees_before_session, :fees_after_session, :fees_on_session, :fees_on_rejoining
  validate :workshop_session_presence

  # Upcoming courses for homepage
  scope :upcoming_workshops, lambda { where("start_date >= ?", Date.today).order(:start_date) }
  scope :show_on_slider, upcoming_workshops.where(show_on_slider: true)
  scope :filter_by_center, ->(centers) { where(center_id: centers) }

  def eligibilities
    course.eligibilities
  end

  # certify all confirmed registrations
  # returns nil if activerecord invalid error is encountered
  # returns count of total confirmed registration if all are updated successfully
  def certify_all_confirmed_registrations
    registrations_to_confirm = registrations.confirmed.uncertified.freshers
    registration_confirmed_count = registrations_to_confirm.count
    begin
      ActiveRecord::Base.transaction do
        registrations_to_confirm.each { |reg| reg.certify }
      end
    rescue ActiveRecord::RecordInvalid => e
      logger.error "ERROR While: certifying all confirmed registrations"
      logger.error "#{e.backtrace.first}: #{e.message} (#{e.class})"
      registration_confirmed_count = e
    end
    registration_confirmed_count
  end

  def any_registration_awaiting_certification?
    !registrations.confirmed.uncertified.blank?
  end

  def donation_receivable(is_fresher, registration_date)
    if is_fresher
      if registration_date <= fees_date.to_date
        fees_before_session
      elsif registration_date < start_date.to_date
        fees_after_session
      else
        fees_on_session
      end
    else
      fees_on_rejoining
    end
  end

  def is_of?(course_alias)
    course.alias == course_alias.to_s
  end
  private

  def workshop_session_presence
    errors.add(:workshop_sessions, "can't be blank") if workshop_sessions.blank?
  end

  # Prepare array of upcoming workshops for home slider
  def self.upcoming_workshops_for_slider
    workshops = []
    show_on_slider.each do |workshop|
      upcoming_workshop_hash = {}
      upcoming_workshop_hash[:image] = Rails.application.routes.url_helpers.website_course_image_path(style: :original, id: workshop.course.id, filename: workshop.course.avatar_file_name) if workshop.course.avatar_file_name.present?
      upcoming_workshop_hash[:name] = workshop.course.name
      upcoming_workshop_hash[:description] = workshop.course.description
      upcoming_workshop_hash[:id] = workshop.course_id
      upcoming_workshop_hash[:url] = Rails.application.routes.url_helpers.website_courses_path(workshop_id: workshop.id)
      upcoming_workshop_hash[:show_on_slider] = workshop.show_on_slider
      workshops << upcoming_workshop_hash
    end
    workshops
  end
end
