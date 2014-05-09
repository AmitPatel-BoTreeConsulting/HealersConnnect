class CertificateObserver < ActiveRecord::Observer
  def after_create(certificate)
    HealersConnectMailer.course_complete_notification(
      certificate.workshop,
      certificate.attendee
    ).deliver
  end
end