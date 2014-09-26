class Location < ActiveRecord::Base
  has_many :users

  def zip_exists?(zip)
    Location.find_by(zip: zip)
  end
end
