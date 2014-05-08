class Workshop < ActiveRecord::Base
  attr_accessible :assistant_instructor_id, :center_id,
    :course_id, :instructor_id,
    :end_date, :start_date,
    :fees_after_session, :fees_before_session, :fees_on_session,
    :fees_on_rejoining, :fees_date,
    :location, :lat, :long, :contact
  attr_accessible :workshop_sessions_attributes
  validates_presence_of :center_id, :course_id, :instructor_id, :fees_date, :location, :contact
  belongs_to :course
  belongs_to :instructor
  belongs_to :assistant_instructor, class_name: 'Instructor'
  belongs_to :center
  has_many :workshop_sessions, dependent: :destroy
  has_many :registrations
  has_many :certificates

  accepts_nested_attributes_for :workshop_sessions, allow_destroy: true, reject_if: proc { |att|  att[:session_start].blank? || att[:session_end].blank?}

  def eligibilities
    course.eligibilities
  end

  # certify all confirmed registrations
  # returns nil if activerecord invalid error is encountered
  # returns count of total confirmed registration if all are updated successfully
  def certify_all_confirmed_registrations
    registrations_to_confirm = registrations.confirmed.uncertified
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
end
