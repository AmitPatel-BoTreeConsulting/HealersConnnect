class RegistrationsController < ApplicationController
  before_filter :collect_payment_types
  before_filter :find_registration, only: [:edit, :update]

  def index
    @registrations = Registration.all
  end

  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(params[:registration])
    if @registration.save
      redirect_to registrations_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private
    def collect_payment_types
      @payment_types = PaymentType.all
    end

    def find_registration
      @registration = Registration.find(params[:id])
    end
end
