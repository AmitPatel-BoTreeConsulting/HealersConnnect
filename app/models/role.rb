class Role < ActiveRecord::Base
  SUPER_ADMIN = 'super_admin'
  CENTER_ADMIN = 'center_admin'
  TEACHER = 'teacher'
  HEALER = 'healer'
  ACCOUNTANT = 'accountant'
  FOUNDATION_ADMIN = 'foundation_admin'

  attr_accessible :name, :alias

  validates_presence_of :name

  has_many :user_roles
  has_many :users, through: :user_roles

  scope :super_admins, where(alias: SUPER_ADMIN)
  scope :center_admins, where(alias: CENTER_ADMIN)
  scope :teachers, where(alias: TEACHER)
  scope :healers, where(alias: HEALER)
  scope :accountants, where(alias: ACCOUNTANT)

  class << self
    def super_admin
      super_admins.first if super_admins
    end

    def accountant
      accountants.first if accountants
    end

    def healer
      healers.first if healers
    end

  end
end
