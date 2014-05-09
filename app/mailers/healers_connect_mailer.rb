class HealersConnectMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)

  def send_donation_notification_to_donor(donation, email, center)
    @donation = donation
    @received_by = email
    @center_name = center
    mail(from: Settings.mail.default_url_options.support_email, to: @donation.donor_email, subject: t('mailer.send_donation_notification_to_donor.subject'))
  end

  def course_complete_notification(workshop, user)
    @workshop = workshop
    @user     = user
    @course   = @workshop.course

    mail(
      from:    Settings.mail.default_url_options.support_email,
      to:      @user.email || @user.user_profile.email,
      subject: t('mailer.course_complete_notification.subject', course_name: @course.name)
    )
  end
end