class HomeController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    @users = User.all
  end

  private

    def set_user
      @user = current_user
    end
end