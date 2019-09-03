class MidpointService
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

  def self.haversine(lat1, lng1, lat2, lng2)
    r = 6371_000
    phi1 = lat1 * Math::PI / 180
    phi2 = lat2 * Math::PI / 180
    delta_phi = (lat2 - lat1) * Math::PI / 180
    delta_lambda = (lng2 - lng1) * Math::PI / 180

    a = Math.sin(delta_phi / 2) * Math.sin(delta_phi / 2) +
    Math.cos(phi1) * Math.cos(phi2) * Math.sin(delta_lambda / 2) *
    Math.sin(delta_lambda / 2)

    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))

    r * c
  end

  def self.spherical_law(lat1, lng1, lat2, lng2)
    Math.acos(Math.sin(lat1) * Math.sin(lat2) + Math.cos(lat1) * Math.cos(lat2) * Math.cos(lng2 - lng1))
  end

  # Point of minimum distance between N geocoordinates
  def self.min_distance(addresses)
    current_point = geo_midpoint(addresses)

    minimum_distance = 0

    addresses.each do |address|
      minimum_distance += spherical_law(address.lat, address.lng, current_point[0], current_point[1])
    end

    return "Don't use this yet"
  end
end
