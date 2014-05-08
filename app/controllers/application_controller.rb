class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_for_signin

  protected

  def after_sign_in_path_for(resource)
    current_user.has_permission?(:registrations) ? workshops_path : root_path
  end

  private
  def layout_for_signin
    devise_controller? ? 'auth' : 'application'
  end

  def require_foundation_admin
    msg = (current_user.is_foundation_admin? ? '' : t('permissions.not_permitted'))
    access_denied_redirect(msg)
  end

  def require_super_admin
    msg = (current_user.is_super_admin? ? '' : t('permissions.not_permitted'))
    access_denied_redirect(msg)
  end

  def require_center_admin
    msg = (current_user.is_center_admin? ? '' : t('permissions.not_permitted'))
    access_denied_redirect(msg)
  end

  def required_accountant
    msg = (current_user.is_accountant? ? '' : t('permissions.not_permitted'))
    access_denied_redirect(msg)
  end

  def required_access
    unless current_user.has_permission?(params[:controller].to_sym)
      access_denied_redirect(t('permissions.not_permitted'))
    end
  end

  def access_denied_redirect(msg)
    if msg.present?
      redirect_to root_path, flash: { error: msg }
    end
  end

  def check_center_admin_access
    # Deny Access to Current User only if
    # user does not have foundation_admin and super_admin role and
    # he tries to access registrations of other centers
    if Registration.should_filter_by_center?(current_user) && !(current_user.centers.include?(@workshop.center))
      access_denied_redirect(t('permissions.not_permitted'))
    end
  end

end
