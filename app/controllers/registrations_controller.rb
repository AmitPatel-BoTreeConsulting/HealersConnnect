class RegistrationsController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :edit, :update]
  load_and_authorize_resource only: [:index, :edit, :update]

  before_filter :collect_payment_types
  before_filter :required_access, only: [:index, :edit, :update, :destroy, :activate, :deactivate, :export]
  before_filter :find_registration, only: [:edit, :update, :activate, :deactivate, :export, :confirm_certify, :certify]
  before_filter :find_workshop, except: [:registration]
  before_filter :set_eligibilities, only: [:new, :create, :edit, :update, :export]
  before_filter :check_center_admin_access, only: [:edit, :update, :destroy, :activate, :deactivate, :export]

  def index
    @registrations = Registration.search(params)
    @registrations = @registrations.filter_by_center(current_user.centers) if Registration.should_filter_by_center?(current_user)
  end

  # Export registration list
  def export_registrations
    check_for_profile()
    respond_to do |format|
      format.html
      format.xls { @registrations = Registration.search(params) }
    end
  end

  def new
    check_for_profile()
    @registration = Registration.new(
      #user_profile_attributes: default_profile_values,
      registration_date: Date.today,
      workshop_id: @workshop.id
    )
    @registration.build_user_profile(gender: 'M', married: true)
  end

  def create
    unless user_signed_in?
      params[:registration][:registration_date] = Time.now
    end

    check_for_profile()
    if @profile.present?
      params[:registration][:user_profile_id] = @profile.id
    end

    @registration = Registration.new(params[:registration])
    if @registration.save
      HealersConnectMailer.delay.registration_notification_to_attendee(@registration)
      HealersConnectMailer.delay.registration_notification_to_center_contact(@registration)

      flash[:notice] = t('registration.message.success.registration_success')
      if current_user
        redirect_to workshop_registrations_path(status: 'confirmed')
      else
        redirect_to root_path
      end
    else
      check_for_profile()
      render :new
    end

  end

  def edit
    @profile = Registration.find(params[:id]).user_profile
  end

  def update
    @registration.concate_certificate_number(params[:registration])
    if @registration.update_attributes(params[:registration])
      flash[:notice] =
        t('registration.message.success.registration_edit_success',
          name: @registration.get_user_profile.name)
      redirect_to workshop_registrations_path(status_search_param)
    else
      render :edit
    end
  end

  def destroy
    @registration = Registration.find(params[:id])
    name = @registration.get_user_profile.name
    @registration.destroy
    flash[:notice] = t('registration.message.success.removed', name: name)
    redirect_to workshop_registrations_path(status_search_param)
  end

  def activate
    update_registration_status_and_redirect(:activate)
  end

  def deactivate
    update_registration_status_and_redirect(:deactivate)
  end

  def export
    @profile = @registration.get_user_profile
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: @profile.first_name,
               template: 'registrations/registration_pdf.html.haml',
               dpi: '96',
               :show_as_html                   => params[:debug].present?,
               disable_internal_links: true, disable_external_links: true,
               :print_media_type => false, :no_background => false
        return
      end
    end
  end

  def confirm_certify
    respond_to do |format|
      format.js do
        render 'registrations/certify/confirm_certify.js.haml'
      end
    end
  end

  def certify
    msg_map = nil
    begin
      @registration.certify
      msg_map = { notice: t('registration.message.success.certify',
          name: @registration.user_profile.name,
          workshop_name: @workshop.course.name
      )}
    rescue ActiveRecord::RecordInvalid => e
      logger.error "ERROR While: certifying all confirmed registrations"
      logger.error "#{e.backtrace.first}: #{e.message} (#{e.class})"
      msg_map = { error: e.record.errors.full_message }
    end
    redirect_to workshop_registrations_path(@workshop), flash: msg_map
  end

  def confirm_certify_all
    @registrations_set_to_certify = @workshop.registrations.certifiable
    @registrations_without_certy_no = @workshop.registrations.certifiable.without_certificate
    respond_to do |format|
      format.js do
        render 'registrations/certify/confirm_certify_all.js.haml'
      end
    end
  end

  def certify_all
    no_of_confirmed_registrations = @workshop.certify_all_confirmed_registrations
    message_map =
      if no_of_confirmed_registrations.instance_of?(ActiveRecord::RecordInvalid)
        { error: t('registration.message.failure.certify_all') }
      else
        { notice: t('registration.message.success.certify_all',
          number_of_confirmed_registration: no_of_confirmed_registrations,
          workshop_name: @workshop.course.name
        )}
      end
    redirect_to workshop_registrations_path(@workshop), flash: message_map
  end

  private
    def collect_payment_types
      @payment_types = PaymentType.all
    end

    def find_registration
      @registration = Registration.find(params[:id])
    end

    def find_workshop
      @workshop = Workshop.find(params[:workshop_id])
    end

    def update_registration_status_and_redirect(action)
      name = @registration.get_user_profile.name
      status, message =
          case action
          when :activate
            [ true, t('registration.message.success.activated', name: name) ]
          when :deactivate
            [ false, t('registration.message.success.deactivated', name: name) ]
          else
          end
      @registration.update_attribute(:active, status)
      redirect_to workshop_registrations_path(status_search_param), flash: { notice:  message }
    end

    def status_search_param
      {status: @registration.active ? 'confirmed' : 'cancelled'}
    end

    def set_eligibilities
      @eligibilities = @workshop.eligibilities
    end

    def check_for_profile
      @profile = UserProfile.find_by_member_id(params[:member_id]) if params[:member_id].present?
    end
end
