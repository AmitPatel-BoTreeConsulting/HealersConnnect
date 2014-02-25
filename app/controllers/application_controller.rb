class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_for_signin

  protected
  def after_sign_in_path_for(resource)
    dashboard_path
  end

  private
  def layout_for_signin
    if devise_controller?
      "auth"
    else
      "application"
    end
  end
end
