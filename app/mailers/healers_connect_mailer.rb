class HealersConnectMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)

  def send_donation_notification_to_donor(donation, email, center)
    @donation = donation
    @received_by = email
    @center_name = center
    mail(from: Settings.mail.default_url_options.support_email, to: @donation.donor_email, subject: t('mailer.send_donation_notification_to_donor.subject'))
  end

  def course_complete_notification(certificate)
    @certificate = certificate
    @workshop = certificate.workshop
    @user     = certificate.attendee
    @course   = @workshop.course

    mail(
      from:    Settings.mail.default_url_options.support_email,
      to:      @user.email || @user.user_profile.email,
      subject: t('mailer.course_complete_notification.subject', course_name: @course.name)
    )
  end

  def workshop_donation_notification(registration_donation)
    @registration_donation = registration_donation
  end
end