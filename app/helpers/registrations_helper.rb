module RegistrationsHelper
  def registration_submit_button
    @registration.new_record? ? 'Register' : 'Save'
  end

  def registration_submit_button_class
    @registration.new_record? ? 'btn' : 'btn btn-primary'
  end
end
