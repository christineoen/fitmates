class Tagsusers < ActiveRecord::Base
  belongs_to :tag
  belongs_to :user
end
