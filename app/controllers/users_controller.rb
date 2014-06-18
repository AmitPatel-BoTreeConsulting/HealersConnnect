class UsersController < ApplicationController

  def index
  end

  def dashboard
  end

  def check_phone_number
    @profiles = UserProfile.where(member_id: params[:member_id]) if params[:member_id]
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

end
