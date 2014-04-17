class Registration < ActiveRecord::Base
  belongs_to :payment_type
  belongs_to :user
  belongs_to :workshop

  has_one :user_profile

  # accepts_nested_attributes_for :workshop
  # attr_accessible :workshop_attributes

  accepts_nested_attributes_for :user_profile
  attr_accessible :user_profile_attributes

  REGISTRATION_STATUSES = %w(confirmed cancelled)

  attr_accessible :payment_type_id, :fresher, :cheque_no, :workshop_id
  attr_accessible :bank_name, :cheque_date, :registration_date

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
end
