class DonationsController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :edit, :update]
  before_filter :find_donation, only: [:show, :export]
  before_filter :required_super_admin_or_accountant, only: [:index]

  def index
    if params[:timeline].present?
      @timeline = params[:timeline]
      if params[:donation].present?
        @donation_params = params[:donation]
        @donations = Donation.search(@donation_params)
      else
        @donations = Donation.all
      end
    else
      @donations = Donation.all
    end

    if @timeline.present?
      donations_by_timeline = Donation.find_donation_by_timeline(@timeline, @donations)
      @donation_chart = Donation.render_chart(data_for_chart: Donation.yearly_donations(donations_by_timeline), chart_type: :bar, chart_name: 'Donations', required_formatter: true, col_x: 'Donation', col_y: 'Donations',  interactive: params[:interactive])
    end

    # Export PDF
    respond_to do |format|
      format.html
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
      @donation.send_donation_notification_to_donar(current_user)
      flash[:notice] = t('donation.message.success.donar_notification')
      redirect_to donations_path
    else
      @centers = Center.all
      render :new
    end
  end

  def export
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
end
