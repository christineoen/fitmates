require 'net/http'
require 'json'

class LocationApiCall

  def self.run(zip)
    url = "https://maps.googleapis.com/maps/api/geocode/json?address='#{zip}'"
    uri = URI(url)
    data = Net::HTTP.get(uri)
    json = JSON.parse(data)

    if json["status"] == 'OK'
      location = Location.find_by(:zip => zip)
      location.latitude = json["results"][0]["geometry"]["location"]["lat"]     
      location.longitude = json["results"][0]["geometry"]["location"]["lng"]
      address_components = json["results"][0]["address_components"]
      
      address_components.each do |component|
        if component["types"][0] == "locality"
          location.city = component["long_name"]
        end
      end
      location.save
    end
  end
end