class HealersConnectMailer < ActionMailer::Base
  def send_donation_notification_to_donar(donation, email)
    @donation = donation
    @received_by = email
    mail(from: Settings.mail.default_url_options.support_email, to: @donation.donar_email, subject: t('mailer.send_donation_notification_to_donar.subject'))
  end
end