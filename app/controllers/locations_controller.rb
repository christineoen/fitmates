class LocationsController < ApplicationController
  before_action :set_user, only: [:edit, :create]


  def edit
    @location = Location.new

    respond_to do |format|
      format.html { redirect_to @user }
      format.js {}
    end

  end

  def create
    # if the zip already exists in the locations table, assign location to user
    if Location::zip_exists?(location_params['zip'])
      @location = Location.find_by(zip: location_params['zip'])
      @user.location_id = @location.id
      @user.save
    else
    # if location doesn't exist, create a new location and update the lat and long
    # using a call to the google geocoding api, and assign location to user
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