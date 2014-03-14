module RegistrationsHelper
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

end
