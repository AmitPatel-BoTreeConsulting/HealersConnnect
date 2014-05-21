class Registration < ActiveRecord::Base
  belongs_to :payment_type
  belongs_to :user
  belongs_to :workshop
  has_one :certificate
  has_one :user_profile
  has_many :registration_donations

  serialize(:past_workshops, Hash)

  # accepts_nested_attributes_for :workshop
  # attr_accessible :workshop_attributes

  accepts_nested_attributes_for :user_profile
  attr_accessible :user_profile_attributes

  REGISTRATION_STATUSES = %w(confirmed cancelled)

  attr_accessible :payment_type_id, :fresher, :cheque_no, :workshop_id, :user_id
  attr_accessible :bank_name, :cheque_date, :registration_date, :past_workshops
  attr_accessible :certificate_number

  attr_accessor :certificate_number_month, :certificate_number_year, :certificate_number_id

  validates_format_of :certificate_number, with: /\A[0-9]{2}\/[0-9]{2}\s[0-9]{1,}\Z/, allow_blank: true
  validates_uniqueness_of :certificate_number, allow_blank: true

  scope :filter_by_center, ->(center) { joins(:workshop).where(workshops: { center_id: center }) }
  scope :confirmed, where(active: true)
  scope :unconfirmed, where(active: false)
  scope :uncertified, where(certified: [false, nil])
  scope :certified, where(certified: true)
  scope :without_certy_no, where(certificate_number: nil)
  scope :freshers, where(fresher: true)

  class << self
    def should_filter_by_center?(user)
      return true if user.is_center_admin? && !user.is_super_admin_or_foundation_admin?
      false
    end
  end

  def donation_complete?
    amount_settled == required_amount
  end

  def amount_settled
    registration_donations.pluck(:amount).sum
  end

  def required_amount
    workshop.send("fees_#{registration_timing}_session")
  end

  def user_profile
    UserProfile.find_by_member_id(member_id)
  end

  def registration_timing
    if registration_date < workshop.fees_date.to_date
      :before
    elsif registration_date > workshop.fees_date.to_date
      :after
    else
      :on
    end
  end

  def course_attempt
    fresher? ? 'Fresher' : 'Review'
  end

  def self.search(params)
    filter_status = params[:status]
    if filter_status.present? && REGISTRATION_STATUSES.include?(filter_status)
      where(active: filter_status == 'confirmed', workshop_id: params[:workshop_id]).order(:registration_date)
    else
      where(workshop_id: params[:workshop_id]).order(:registration_date)
    end
  end

  def get_user_profile
    user_profile || user.user_profile
  end

  def certificate_number_splitted
    @certificate_number_splitted ||= certificate_number.split(/[\/ ]/) rescue []
  end

  # Export registration list
  def self.export_registration(params, options = {})
    registrations = search(params)
    CSV.generate(options) do |csv|
      csv << column_names
      registrations.each do |registration|
        csv << registration.attributes.values_at(*column_names)
      end
    end
  end

  def concate_certificate_number(certificate_number_map)
    month = certificate_number_map.delete(:certificate_number_month)
    year = certificate_number_map.delete(:certificate_number_year)
    id = certificate_number_map.delete(:certificate_number_id)
    if month.blank? && year.blank? && id.blank?
      erase_certificate_number
    else
      set_certificate_number(month, year, id)
    end
  end

  def set_certificate_number(month, year, id)
    certificate_number_str = "#{month}/#{year} #{id}"
    self.certificate_number = certificate_number_str
  end

  def erase_certificate_number
    self.certificate_number = nil
  end

  def certificate_number_month
    return if certificate_number.blank?
    certificate_number_splitted[0]
  end

  def certificate_number_year
    return if certificate_number.blank?
    certificate_number_splitted[1]
  end

  def certificate_number_id
    return if certificate_number.blank?
    certificate_number_splitted[2]
  end

  def certify
    update_attribute(:certified, true)
    attendee = User.find_by_member_id(user_profile.member_id)
    if attendee.blank?
      # If user not found then create new user from user_profile
      attendee = User.create_from_user_profile!(user_profile)
      update_attribute(:user_id, attendee.id)
    end
    create_certificate!(user_id: user_id, workshop_id: workshop_id)
  end

  def donation_receivable
    workshop.donation_receivable(fresher, registration_date)
  end

  def donation_received
    registration_donations.sum(:amount)
  end
end
