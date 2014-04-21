class User < ActiveRecord::Base
  has_one :user_profile
  has_many :workshops
  has_many :registrations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, authentication_keys: [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :mobile, :password, :password_confirmation, :remember_me
  attr_accessible :login
  # attr_accessible :title, :body

  has_many :donations
  has_many :user_roles
  has_many :roles, through: :user_roles

  def is_foundation_admin?
    have_role?(Role::FOUNDATION_ADMIN)
  end

  def is_super_admin?
    have_role?(Role::SUPER_ADMIN)
  end

  def is_accountant?
    have_role?(Role::ACCOUNTANT)
  end

  def is_center_admin?
    have_role?(Role::CENTER_ADMIN)
  end

  def is_instructor?
    have_role?(Role::INSTRUCTOR)
  end

  def have_role?(role_type)
    roles.pluck(:alias).include? role_type if roles
  end

  def has_permission?(controller)
    case controller
    when :centers
      have_role?(Role::SUPER_ADMIN) ||
      have_role?(Role::FOUNDATION_ADMIN) ||
      have_role?(Role::CENTER_ADMIN)
    when :courses
      have_role?(Role::SUPER_ADMIN) ||
      have_role?(Role::FOUNDATION_ADMIN) ||
      have_role?(Role::CENTER_ADMIN) ||
      have_role?(Role::INSTRUCTOR)
    when :instructors, :registrations
      have_role?(Role::SUPER_ADMIN) ||
      have_role?(Role::FOUNDATION_ADMIN)
    when :donations
      have_role?(Role::SUPER_ADMIN) ||
      have_role?(Role::FOUNDATION_ADMIN) ||
      have_role?(Role::ACCOUNTANT) ||
      have_role?(Role::CENTER_ADMIN)
    else
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(['lower(mobile) = :value OR lower(email) = :value', { value: login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def login=(login)
    @login = login
  end

  def login
    @login || mobile || email
  end

end
