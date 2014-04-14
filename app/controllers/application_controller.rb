class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :layout_for_signin

  protected
  def after_sign_in_path_for(resource)
    registrations_path(status: 'confirmed')
  end

  private
  def layout_for_signin
    if devise_controller?
      "auth"
    else
      "application"
    end
  end

  def require_foundation_admin
    msg = (current_user.is_foundation_admin? ? '' : t('permissions.foundation_admin_rights_required'))
    access_denied_redirect(msg)
  end

  def required_super_admin_or_accountant
    msg = (current_user.is_super_admin_or_accountant? ? '' : t('permissions.foundation_admin_rights_required'))
    access_denied_redirect(msg)
  end

  def access_denied_redirect(msg)
    if msg.present?
      redirect_to root_path, flash: { error: msg }
    end
  end
end
