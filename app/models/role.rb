class Role < ActiveRecord::Base
  SUPER_ADMIN_ROLE_TYPE = 'super_admin'
  CENTER_ADMIN_ROLE_TYPE = 'center_admin'
  TEACHER_ROLE_TYPE = 'teacher'
  HEALER_ROLE_TYPE = 'healer'

  attr_accessible :name

  validates_presence_of :name

  scope :super_admin, where(name: SUPER_ADMIN_ROLE_TYPE)
  scope :center_admin, where(name: CENTER_ADMIN_ROLE_TYPE)
  scope :teacher, where(name: TEACHER_ROLE_TYPE)
  scope :healer, where(name: HEALER_ROLE_TYPE)
end
