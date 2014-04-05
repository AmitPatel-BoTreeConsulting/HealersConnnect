class Registration < ActiveRecord::Base
  attr_accessible :first_name, :middle_name, :last_name, :birth_date, :education, :occupation, :gender, :married,
                  :address, :mobile,  :telephone, :email, :location, :long, :lat, :workshop_place, :workshop_dated,
                  :workshop_instructor, :payment_type_id, :fresher, :cheque_no, :bank_name, :cheque_date, :registration_date

  validates_presence_of :first_name, :middle_name, :last_name, :birth_date, :education, :occupation,
                        :address, :workshop_place, :workshop_dated, :workshop_instructor

  validates :email, presence: true, :format => {:with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/}

  belongs_to :payment_type

  REGISTRATION_STATUSES = %w(confirmed cancelled)

  def name
    "#{first_name} #{middle_name} #{last_name}"
  end

  def marital_status
    married? ? 'Married' : 'Unmarried'
  end

  def course_attempt
    fresher? ? 'Fresher' : 'Review'
  end

  def self.search(params)
    filter_status = params[:status]
    if filter_status.present? && REGISTRATION_STATUSES.include?(filter_status)
      where(active: filter_status == 'confirmed').order(:registration_date)
    else
      order(:registration_date)
    end
  end

  # Export registration list
  def self.export_registration(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |registration|
        csv << registration.attributes.values_at(*column_names)
      end
    end
  end
end
