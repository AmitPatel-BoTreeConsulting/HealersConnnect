class Foundation < ActiveRecord::Base
  attr_accessible :name, :parent, :alias

  has_ancestry
  has_many :centers
end
