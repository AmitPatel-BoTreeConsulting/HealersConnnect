module RegistrationDonationsHelper
  def registration_donation_receivable_statistics
    @receivable = @registration.donation_receivable
    "#{t('registration_donation.caption.receivable')}(₹): #{@receivable}"
  end

  def registration_donation_received_statistics
    @received = @registration.donation_received
    "#{t('registration_donation.caption.received')}(₹):  #{@received}"
  end

  def registration_donation_pending_statistics
    "#{t('registration_donation.caption.pending')}(₹): #{@receivable - @received}"
  end
end
