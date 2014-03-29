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
end
