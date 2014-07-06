class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_super_admin?
      can :manage, [Event, Center, Course, Instructor]
      can :read, [Workshop, Registration]
    elsif user.is_center_admin?
      can :manage, [Workshop, Donation, EventSchedule, Registration]
    elsif  user.is_accountant?
      can :manage, Donation
    elsif user.is_registrar?
      can :manage, Registration
    end
  end
end
