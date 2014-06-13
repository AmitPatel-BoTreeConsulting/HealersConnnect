class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_for_signin
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error]  = "Access denied."
    redirect_to root_url
  end
  
  private
  def layout_for_signin
    devise_controller? ? 'auth' : 'application'
  end
end
