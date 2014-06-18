class RegistrationDonationObserver < ActiveRecord::Observer
  def after_create(registration_donation)
    puts "^%&^%&^%&^%&^%&^%&^%&^%&^%&^%&^%&^%&^%&^%&^%&^%&^%&^%&^%&"
    HealersConnectMailer.delay.registration_donation_notification(registration_donation)
  end
end