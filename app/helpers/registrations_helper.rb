module RegistrationsHelper
  def registration_submit_button
    @registration.new_record? ? 'Register' : 'Save'
  end
end
