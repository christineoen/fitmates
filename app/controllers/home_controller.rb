class HomeController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    @users = User.all
    users_within_radius = {}
    if @user.search_radius && @user.location_id
      user_hash = @user.within_radius(@user.search_radius)
      user_objects = user_hash.map {|user| User.create(user)}
      user_objects.each do |user|
        users_within_radius[user] = @user.similar_to(user)
      end
      @users_within_radius = users_within_radius.sort_by {|k,v|v}.reverse
      # @users_within_radius = SortByMatchPercentage.run(users_within_radius)
    else
      #displays all users except current user before user specifies a search radius 
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