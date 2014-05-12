class RegistrationDonationsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_registration_and_workshop
  before_filter :check_center_admin_access

  def index
    @registration_donations = RegistrationDonation.where(registration_id: @registration.id)
  end

  def new
    @registration_donation = RegistrationDonation.new
  end

  def create
    @registration_donation = RegistrationDonation.create(
      params[:registration_donation].merge({
        user_id: current_user.id,
        registration_id: @registration.id
      })
    )
    if @registration_donation.persisted?
      flash[:notice] = t('registration_donation.message.success.creation')
      redirect_to workshop_registration_registration_donations_path(@workshop, @registration)
    else
      render :new
    end
  end

  private

  def set_registration_and_workshop
    @workshop     = Workshop.find_by_id(params[:workshop_id])
    @registration = Registration.find_by_id(params[:registration_id])
  end
end
