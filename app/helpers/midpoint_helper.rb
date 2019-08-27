class MidpointHelper
  def self.geo_midpoint(addresses)
    # X, Y, Z arrays for storing converted geolocations
    x = []
    y = []
    z = []

    # Convert Geolocations to Coordinates and add them the the X, Y and Z arrays
    addresses.each do |address|
      lat = address.lat * Math::PI / 180
      lng = address.lng * Math::PI / 180
      x << Math.cos(lat) * Math.cos(lng)
      y << Math.cos(lat) * Math.sin(lng)
      z << Math.sin(lat)
    end

    # Average the coordinates
    x = x.inject { |sum, el| sum + el }.to_f / x.size
    y = y.inject { |sum, el| sum + el }.to_f / y.size
    z = z.inject { |sum, el| sum + el }.to_f / z.size

    # Convert Coorindates back to radians
    hyp = Math.sqrt(x * x + y * y)
    lat = Math.atan2(z, hyp)
    lng = Math.atan2(y, x)

    # Convert radians to degrees
    lat = lat * 180 / Math::PI
    lng = lng * 180 / Math::PI

    return [lat, lng]
  end

  # Distance between 2 geocoordinates
  def self.distance(lat1, lng1, lat2, lng2)
    Math.acos(Math.sin(lat1) * Math.sin(lat2) + Math.cos(lat1) * Math.cos(lat2) * Math.cos(lng2 - lng1))
  end
end
