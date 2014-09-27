class User < ActiveRecord::Base
  has_attached_file :photo, :styles => { :medium => "250x250#", :small => "150x150#", :thumb => "30x30#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_file_name :photo, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]
  has_many :taggings
  has_many :tags, through: :taggings
  belongs_to :location
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def within_radius(search_radius)
    # return list of users who are within the search radius
    # meter * 0.000621371 = mile
    # meter = mile / 0.000621371

    radius_in_metres = search_radius / 0.000621371
    latitude = location.latitude.to_s.to_f
    longitude = location.longitude.to_s.to_f
    query_string = ""

    #find locations within the current users search radius
    locations_within_radius = ActiveRecord::Base.connection.execute("SELECT locations.id, locations.city 
      FROM locations WHERE earth_box(ll_to_earth(#{latitude}, #{longitude}), #{radius_in_metres}) 
      @> ll_to_earth(locations.latitude, locations.longitude)")

    #put location_id's into a string to query users and remove trailing 'or' from string
    locations_within_radius.each do |location|
      query_string << "location_id = #{location['id']} or "
    end
    query_string = query_string[0..-5]

    # find user id's within radius
    users_within_radius = ActiveRecord::Base.connection.execute("SELECT * from users WHERE #{query_string}")
  end

  def similiar_to

  end

end



