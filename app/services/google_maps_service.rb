require 'uri'

class GoogleMapsService
  def self.gmaps_link(bar)
    name = URI::encode(bar.name)
    "https://google.com/maps/search/#{name}/@#{bar.lat},#{bar.lng}"
  end
end
