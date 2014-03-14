class RegistrationsController < ApplicationController
  before_filter :authenticate_user!, only: [:index, :edit, :update]
  before_filter :collect_payment_types
  before_filter :find_registration, only: [:edit, :update]

  def index
    @registrations = Registration.order(:created_at)
  end

  def new
    @registration = Registration.new(gender: 'M', married: true)
  end

  def create
    @registration = Registration.new(params[:registration])
    if @registration.save
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

  private
    def collect_payment_types
      @payment_types = PaymentType.all
    end

    def find_registration
      @registration = Registration.find(params[:id])
    end
end
