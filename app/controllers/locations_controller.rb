class LocationsController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :create]


  def create
    if Location::zip_exists?(location_params['zip'])
      @location = Location.find_by(zip: location_params['zip'])
      @user.location_id = @location.id
      @user.save
    else
      Location.create(zip: location_params['zip'])
      LocationApiCall.run(location_params['zip'])
      location = Location.find_by(zip: location_params['zip'])
      @user.location_id = location.id
      @user.save
    end
    redirect_to @user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

  def location_params
    params.require(:location).permit(:zip, :latitude, :longitude, :city)
  end

end 