class HealersConnectMailer < ActionMailer::Base
  def send_donation_notification_to_donor(donation, email, center)
    @donation = donation
    @received_by = email
    @center_name = center
    mail(from: Settings.mail.default_url_options.support_email, to: @donation.donor_email, subject: t('mailer.send_donation_notification_to_donor.subject'))
  end
end