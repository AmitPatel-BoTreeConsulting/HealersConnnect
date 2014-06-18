module RegistrationsHelper
  REGISTRATION_STATUSES = %w(confirmed cancelled)

  def registration_submit_button
    @registration.new_record? ? 'Register' : 'Save'
  end

  def registration_submit_button_class
    @registration.new_record? ? 'btn' : 'btn btn-primary'
  end

  def cheque_details_visibility
  	visible = @registration.payment_type.present? ? @registration.payment_type.alias == 'cheque' : false
  	display_style(visible)
  end

  def net_banking_details_visibility
  	visible = @registration.payment_type.present? ? @registration.payment_type.alias == 'net_banking' : false
  	display_style(visible)
  end

  def active_pill(status=nil)
    css_class = ''
    filter_status = params[:status]
    if status.present? && filter_status.present? && filter_status == status
      css_class = 'active'
    elsif status.blank? && filter_status.present? && !REGISTRATION_STATUSES.include?(filter_status)
      css_class = 'active'
    elsif status.blank? && filter_status.blank?
      css_class = 'active'
    end
    css_class
  end

  def url_for_registration_form(registration, workshop)
    if registration.new_record?
      workshop_registrations_path(workshop)
    else
      workshop_registration_path(id: registration, workshop_id: workshop)
    end
  end

  def set_profile(registration)
    if registration.user
      registration.user_profile = registration.user.user_profile
    else
      registration.build_user_profile
    end
    registration
  end

  def cancel_registration_path
    if user_signed_in?
      workshop_registrations_path(@workshop)
    else
      root_path
    end
  end
end
