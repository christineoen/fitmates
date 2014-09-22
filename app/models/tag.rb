class Tag < ActiveRecord::Base
  has_many :users, through: :tagsusers
  has_many :tagsusers
end
