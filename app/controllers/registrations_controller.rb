class RegistrationsController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :edit, :update]
  before_filter :collect_payment_types
  before_filter :find_registration, only: [:edit, :update]

  def index
    @registrations = Registration.order(:registration_date)
  end

  def new
    @registration = Registration.new(gender: 'M', married: true, registration_date: Date.today)
  end

  def create
    @registration = Registration.new(params[:registration])
    if @registration.save
      unless current_user.present?
        @registration.registration_date = @registration.created_at
        @registration.save
      end

      flash[:notice] = t('registration.message.success.registration_success')
      if current_user
        redirect_to registrations_path
      else
        redirect_to root_path
      end
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @registration.update_attributes(params[:registration])
      flash[:notice] =
        t('registration.message.success.registration_edit_success', name: @registration.name)
      redirect_to registrations_path
    else
      render :edit
    end
  end

  def destroy
    @registration = Registration.find(params[:id])
    @registration.destroy
    flash[:notice] = t('registration.message.success.removed', name: @registration.name)
    redirect_to registrations_path
  end

  def activate
    update_registration_status_and_redirect(:activate, params[:registration_id])
  end

  def deactivate
    update_registration_status_and_redirect(:deactivate, params[:registration_id])
  end

  private
    def collect_payment_types
      @payment_types = PaymentType.all
    end

    def find_registration
      @registration = Registration.find(params[:id])
    end

    def update_registration_status_and_redirect(action, id)
      @registration = Registration.find(id)
      name = @registration.name
      status, message = case action
                          when :activate
                            [ true, t('registration.message.success.activated', name: name) ]
                          when :deactivate
                            [ false, t('registration.message.success.deactivated', name: name) ]
                        end
      @registration.update_attribute(:active, status)
      redirect_to registrations_path, flash: { notice:  message }
    end
end
