class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :donations
  has_many :user_roles
  has_many :roles, through: :user_roles

  def is_foundation_admin?
    return true if have_role?(Role::FOUNDATION_ADMIN)
    false
  end

  def is_super_admin_or_accountant?
    return true if( have_role?(Role::SUPER_ADMIN) || have_role?(Role::ACCOUNTANT) )
    false
  end

  def have_role?(role_type)
    return self.roles.pluck(:alias).include? role_type if self.roles
    false
  end
end
