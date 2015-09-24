class DonationsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource only: [:index, :new, :create]

  #before_filter :find_donation, only: [:show, :export]
  #before_filter :required_access, only: [:index, :new, :create, :export]

  def index
    if params[:timeline].present?
      @timeline = params[:timeline]
      params[:user_id] = current_user.id if current_user.is_center_admin?
      if params[:donation].present?
        @donation_params = params[:donation]
        @donations = Donation.page(params[:page]).per(Settings.pagination.per_page_5).search(@donation_params)
        # call_ajax()
      else
        donation_listing()
      end
    else
      donation_listing()
    end

    if @timeline.present?
      donations_by_timeline = Donation.find_donation_by_timeline(@timeline, @donations)
      @donation_chart = GoogleChartService.render_pie_chart(data_for_chart: Donation.yearly_donations(donations_by_timeline), chart_type: :bar, chart_name: 'Donations', required_formatter: true, col_x: 'Donation', col_y: 'Donations',  interactive: params[:interactive])
    end

  # Export PDF
    respond_to do |format|
      format.html
      format.js { render 'donation.js.erb'}
      format.pdf do
        render pdf: 'report',
               template: 'donations/donation_report_pdf.html.haml',
               dpi: '96',
               :show_as_html                   => params[:debug].present?,
               disable_internal_links: true, disable_external_links: true,
               :print_media_type => false, :no_background => false
        return 
      end
    end
  end

  def new
    @donation = Donation.new
    @centers = Center.all
  end

  def create
    @donation = Donation.new(params[:donation])
    if @donation.save
      @donation.send_donation_notification_to_donor(current_user)
      flash[:notice] = t('donation.message.success.donor_notification')
      redirect_to donations_path
    else
      @centers = Center.all
      render :new
    end
  end

  def export
    find_donation()
    authorize! :export_donation, @donation
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'donation',
               template: 'donations/donation_pdf.html.haml',
               dpi: '96',
               :show_as_html                   => params[:debug].present?,
               disable_internal_links: true, disable_external_links: true,
               :print_media_type => false, :no_background => false
        return
      end
    end
  end

  private
    def find_donation
      @donation = Donation.find(params[:id])
    end

    def donation_listing
      if current_user.is_center_admin?
        @donations = Donation.page(params[:page]).per(Settings.pagination.per_page_5).for_center(current_user.center_ids)
        # call_ajax   
      else if current_user.is_accountant?
         @donations = Donation.for_center(current_user.center_ids).received_by(current_user)
       else
         @donations = Donation.all
       end
      end
    end

    # def call_ajax
    #   respond_to do |format|
    #   format.js { render 'donation.js.erb'}
    #   format.html
    #   end
    # end
end