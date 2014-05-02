class UsersController < ApplicationController

  def index
  end

  def dashboard
  end

  def check_phone_number
    @profiles = find_user_profile_from_member_id if params[:member_id]
    @workshop = Workshop.find_by_id(params[:workshop_id])
    if @profiles.blank?
      @profiles = UserProfile.where(mobile: params[:mobile])
      # match telephone number only if mobile is not provided
      if params[:mobile].blank?
        @profiles = UserProfile.where(telephone: params[:telephone])
      end
    end

    respond_to do |format|
      format.js
    end
  end

  private

  def find_user_profile_from_member_id
    profile = User.find_by_member_id(params[:member_id].to_i).try(:user_profile)
    [profile] if profile
  end
end
