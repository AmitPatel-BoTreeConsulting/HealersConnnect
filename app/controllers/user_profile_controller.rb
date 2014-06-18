class UserProfileController < ApplicationController
  def index
    @page = params[:page] || 1
    @user_profiles = UserProfile.page(params[:page]).per(Settings.pagination.per_page).order(:first_name)
  end
end
