class HomeController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    @users = User.all
    users_within_radius = {}
    # checks to see if the user has specified a search radius and a location before running
    # the within_radius method.  If they haven't, or if the search radius is zero, it
    # returns all users to appear in the feed.  Both options run the similar_to method
    # which calculates a match percentage on each user.
    if @user.search_radius && @user.location_id && @user.search_radius != 0
      # the within_radius method returns a postgres result which needs to be turned into objects
      pg_users = @user.within_radius(@user.search_radius)
      user_objects = pg_users.map {|user| User.create(user)}
      # to have the users show up on the feed in order of match percentage, I created a hash with the
      # user as the key and the match percentage as the value, and sorted it by the value.
      user_objects.each do |user|
        users_within_radius[user] = @user.similar_to(user)
      end
      @users_within_radius = users_within_radius.sort_by {|k,v|v}.reverse
    else
      # displays all users except current user before user specifies a search radius 
      user_objects = User.where.not(id: @user.id)
      user_objects.each do |user|
        users_within_radius[user] = @user.similar_to(user)
      end
      @users_within_radius = users_within_radius.sort_by {|k,v|v}.reverse
    end
  end

  private

    def set_user
      @user = current_user
    end
end