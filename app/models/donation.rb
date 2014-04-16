class Donation < ActiveRecord::Base
  FOR_CENTER = 1
  FOR_FOOD_FOR_HUNGRY = 2
  attr_accessible :center_id, :description, :donation_type, :user_id, :donar_name, :donar_email, :amount
  acts_as_sequenced scope: :receipt_number
  acts_as_sequenced start_at: 1

  validates_presence_of :donar_name, :amount, :center_id
  #validates :donar_email, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
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
    "#{Time.now.year}#{Time.now.strftime('%m')}/#{"%04d" % sequential_id.to_s}"
  end

  # Search donations with Multiselectbox
  def self.search(params)
    unless params.nil?
      donations = Donation.where('donation_type in (?)', params[:donation_type]) if params[:donation_type].present?
      donations = Donation.joins(:user).where(users: { id: params[:user_id] }) if params[:user_id].present?
    else
      donations = Donation.all
    end
    donations
  end

  # Find donations by timline like weekly,monthly,yearly or by both for render chart
  def self.find_donation_by_timeline(timeline, donations)
    donations = donations.present? ? donations : Donation.all
    donations_by_timeline = case timeline
    when 'weekly'
    when 'monthly'
    when 'yearly'
      Hash[donations.group_by{ |u| u.created_at.beginning_of_month }.to_a.sort]
    end
  end

  # Find donations by "yearly" for chart
  def self.yearly_donations(donations)
    @array_for_yearly_chart = []
      donations.each do |month,donations|
        @array_for_yearly_chart << ["#{month.strftime('%B')}", donations.count.to_i]
    end
    @array_for_yearly_chart
  end

  # Render Chart
  def self.render_chart(options = {})
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', options[:col_x])
    data_table.new_column('number', options[:col_y])
    data_table.add_rows(options[:data_for_chart])

    if options[:required_formatter]
      formatter = GoogleVisualr::ArrowFormat.new
      formatter.columns(1)
      data_table.format(formatter)
    end
    opts = { :title => options[:chart_name], :legend => 'bottom' }
    options[:chart_type] == :bar
      if !options[:interactive].present?
        chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)
      else
        chart = GoogleVisualr::Image::BarChart.new(data_table, opts)
      end
    chart
  end
end
