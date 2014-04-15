class Donation < ActiveRecord::Base
  FOR_CENTER = 1
  FOR_FOOD_FOR_HUNGRY = 2
  attr_accessible :center_id, :description, :donation_type, :received_by_user_id, :user_id, :donar_name, :donar_email, :amount

  acts_as_sequenced scope: :receipt_number
  acts_as_sequenced start_at: 1

  validates_presence_of :donar_name, :amount, :center_id
  validates :donar_email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :amount, :numericality => true

  belongs_to :user
  belongs_to :center

  after_create :add_unique_donation_receipt_number

  def send_donation_notification_to_donar(user)
    begin
      HealersConnectMailer.delay.send_donation_notification_to_donar(self, user.email, self.center.name)
    rescue Exception => e
      Rails.logger.error "Failed to send email, email address: #{self.donar_email}"
      Rails.logger.error "#{e.backtrace.first}: #{e.message} (#{e.class})"
    end
  end

  def add_unique_donation_receipt_number
    update_attribute(:receipt_number, generate_unique_receipt_number)
  end

  def generate_unique_receipt_number
    "#{Time.now.year}#{Time.now.strftime('%m')}##{"%04d" % sequential_id.to_s}"
  end
end
