class Registration < ActiveRecord::Base
  belongs_to :payment_type
  belongs_to :user
  belongs_to :workshop

  has_one :user_profile

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
    certificate_number.split(/[\/ ]/) rescue []
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
end
