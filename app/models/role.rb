class Role < ActiveRecord::Base
  SUPER_ADMIN = 'super_admin'
  CENTER_ADMIN = 'center_admin'
  TEACHER = 'teacher'
  HEALER = 'healer'
  ACCOUNTANT = 'accountant'
  FOUNDATION_ADMIN = 'foundation_admin'

  attr_accessible :name, :alias

  validates_presence_of :name

  scope :super_admin, where(name: SUPER_ADMIN)
  scope :center_admin, where(name: CENTER_ADMIN)
  scope :teacher, where(name: TEACHER)
  scope :healer, where(name: HEALER)
end
