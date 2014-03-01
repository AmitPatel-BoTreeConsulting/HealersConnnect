class Foundation < ActiveRecord::Base
  attr_accessible :name, :parent

  has_ancestry
  has_many :centers
end
