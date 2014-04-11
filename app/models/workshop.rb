class Workshop < ActiveRecord::Base
  belongs_to :registration
  belongs_to :user

  attr_accessible :workshop_dated, :workshop_instructor, :workshop_place

  validates_presence_of :workshop_dated, :workshop_instructor, :workshop_place
end
