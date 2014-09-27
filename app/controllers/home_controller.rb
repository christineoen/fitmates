class HomeController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    @users = User.all
    if current_user.search_radius && current_user.location_id
      user_hash = @user.within_radius(@user.search_radius)
      @users_within_radius = user_hash.map {|user| User.create(user)}
    end
  end

  private

    def set_user
      @user = current_user
    end
end