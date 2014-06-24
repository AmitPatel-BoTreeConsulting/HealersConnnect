class UserRole < ActiveRecord::Base
  belongs_to :role
  belongs_to :user
  belongs_to :center

  attr_accessible :role_id, :user_id
end
