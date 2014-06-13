class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is? Role::SUPER_ADMIN
        can :manage, [Center, Course, Instructor]
    end
    if user.is? Role::CENTER_ADMIN
        can :manage, [Workshop, Donation, Event, EventSchedule, Registration]
    end
    if  user.is? Role::INSTRUCTOR
        can :manage, Instructor
    end
    if  user.is? Role::ACCOUNTANT
        can :manage, Donation
    end
    if user.is? Role::REGISTRAR_ADMIN
    	can :manage, Registration
    end
  end
end
