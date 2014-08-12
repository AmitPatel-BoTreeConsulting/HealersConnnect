class UserProfileController < ApplicationController
  before_filter :authenticate_user!

  def index    
  @page = params[:page] || 1 
  @user_profiles = UserProfile.in_search(params[:uname]).page(params[:page]).per(Settings.pagination.per_page).order(:first_name)
  respond_to do |format| 
    format.html
    format.js
  end
  end
end
