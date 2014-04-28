class UsersController < ApplicationController

  def index
  end

  def dashboard
  end

  def check_phone_number
    @profile = UserProfile.find_by_mobile(params[:mobile])
    # match telephone number only if mobile is not provided
    if params[:mobile].blank?
      @profile ||= UserProfile.find_by_telephone(params[:telephone])
    end
    respond_to do |format|
      format.js
    end
  end
end
