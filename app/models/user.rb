class User < ActiveRecord::Base
  has_attached_file :photo, :styles => { :medium => "250x250#", :small => "150x150#", :thumb => "30x30#" }, :default_url => "/images/:style/missing.png"
  validates_attachment_file_name :photo, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]
  has_many :taggings
  has_many :tags, through: :taggings
  belongs_to :location
  has_many :messages
  has_many :participants
  has_many :conversations, through: :participants
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def within_radius(search_radius)

    # meter * 0.000621371 = mile
    # meter = mile / 0.000621371
    radius_in_metres = search_radius / 0.000621371

    # grab current user's location
    latitude = location.latitude
    longitude = location.longitude

    # start query string, which removes current user from query
    query_string = "SELECT * from users WHERE id != #{id} and ("

    # find locations within the current users search radius using psql extensions cube and earthdistance
    locations_within_radius = ActiveRecord::Base.connection.execute("SELECT locations.id, locations.city 
      FROM locations WHERE earth_box(ll_to_earth(#{latitude}, #{longitude}), #{radius_in_metres}) 
      @> ll_to_earth(locations.latitude, locations.longitude)")

    # put location_id's into a string to query users and remove trailing 'or' from string
    # the brackets are needed in order to remove the current user from the result
    locations_within_radius.each {|location| query_string << "location_id = #{location['id']} or "}
    query_string = query_string[0..-5] + ")"

    # find users within radius
    users_within_radius = ActiveRecord::Base.connection.execute("#{query_string}")
  end

  def similar_to(other_user)
    # called on current_user, pass in user comparing to

    @tags = Tag.all
    base_array = []
    tag_array1 = []
    tag_array2 = []

    #put all tag id's available into an array and sort
    @tags.each {|tag| base_array << tag.id}
    base_array = base_array.sort

    #put all tag id's belonging to the user being compared to into an array
    Tagging.where(user_id: other_user.id).each {|tag| tag_array1 << tag.tag_id}

    #put all tag id's belonging to current user into an array
    tags.each {|tag| tag_array2 << tag.id}

    #create base array length arrays out of each user tag array, putting a 1 in place
    #of the tag id if the user has that tag, and a zero if they don't
    tag_array1 = base_array.map {|tag_id| tag_array1.include?(tag_id) ? 1 : 0 }
    tag_array2 = base_array.map {|tag_id| tag_array2.include?(tag_id) ? 1 : 0 }

    # if one person doesn't have any tags selected return zero, otherwise run cosine similarity.
    # need this if statement to avoid NaN errors
    if tag_array1.inject {|sum, n| sum + n} == 0 || tag_array2.inject {|sum, n| sum + n} == 0
      return 0
    else
      (cosine_similarity(tag_array1, tag_array2).round(2) * 100).round(0)
    end
  end

  def dot_product(tag_array1, tag_array2)
    products = tag_array1.zip(tag_array2).map{|a, b| a * b}
    products.inject(0) {|s,p| s + p}
  end

  def magnitude(tag_array)
    squares = tag_array.map{|x| x ** 2}
    Math.sqrt(squares.inject(0) {|s, c| s + c})
  end

  def cosine_similarity(tag_array1, tag_array2)
    dot_product(tag_array1, tag_array2) / (magnitude(tag_array1) * magnitude(tag_array2))
  end

end

