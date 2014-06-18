class CertificateObserver < ActiveRecord::Observer
  def after_create(certificate)
    HealersConnectMailer.delay.course_complete_notification(certificate)
  end
end