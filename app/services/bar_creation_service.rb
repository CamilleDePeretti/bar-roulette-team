class BarCreationService
  def self.create_bars(night, cat)
    Hashie.logger = Logger.new('/dev/null') # Fix Hashie bug warning

    bar_amnt = 6
    search_radius = 250
    increment = 100

    results = FoursquareService.bars_get(night, bar_amnt, search_radius, increment, cat.to_sym)

    puts "Finishing getting the #{results['venues'].length} bars, now to create them"

    results['venues'].each do |result|
      name = result['name'].to_s
      lat = result['location']['lat'].to_s
      lng = result['location']['lng'].to_s
      city = result['location']['city'].to_s
      address = result['location']['formattedAddress'].join(', ')
      category = result['categories'].first['name'].to_s
      foursquare_id = result['id'].to_s
      details = FoursquareService.details_get(foursquare_id)
      contact = details['contact']
      photos = FoursquareService.photos_get(foursquare_id)
      hours = FoursquareService.hours_get(foursquare_id)

      puts "Creating bar #{name}. Address: #{address}"
      Bar.create!(
        name: name, lat: lat, lng: lng, address: address, category: category,
        night: night, foursquare_id: foursquare_id, photos: photos, hours: hours,
        contact: contact, details: details, city: city
      )
    end
  end
end
