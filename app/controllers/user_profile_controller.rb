class UserProfileController < ApplicationController
  before_filter :authenticate_user!

  def index
    @page = params[:page] || 1
    @user_profiles = UserProfile.page(params[:page]).per(Settings.pagination.per_page).order(:first_name)
  end

  def autocomplete
  	user_profiles = UserProfile.order(:first_name).where("first_name ILIKE ?","%#{params[:term]}%")
 	
 	data=[]

  	user_profiles.each do |user_profile|
  		data << { label: "#{user_profile.name} [#{user_profile.mobile}]", value: user_profile.member_id }
  	end

  	respond_to do |format|
      format.html
      format.json {
        render json: data
      }
 	end
  end

end
