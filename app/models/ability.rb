class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_super_admin?
      can :manage, [Event, Center, Course, Instructor]
      can :read, [Workshop, Registration]
      can [:read, :export_donation], Donation
    elsif user.is_center_admin?
      can :manage, Workshop do |workshop|
        user.center_ids.include?(workshop.center_id)
      end
      can :create, Workshop

      can :manage, Registration do |registration|
        user.center_ids.include?((registration.workshop.center_id))
      end

      can :manage, RegistrationDonation do |registration_donation|
        user.center_ids.include?((registration_donation.registration.workshop.center_id))
      end

      can :manage, EventSchedule do |event_schedule|
        user.center_ids.include?(event_schedule.center.id)
      end
      can :create, EventSchedule

      can [:create, :read], Donation
      can :export_donation, Donation do |donation|
        user.center_ids.include?(donation.center_id)
      end

    elsif  user.is_accountant?
      can [:create, :read], Donation
      can :export_donation, Donation, :user_id => user.id
    elsif user.is_registrar?
      can :manage, Registration
    end
  end
end
