class BarCreationService
  def self.create_bars(night)
    Hashie.logger = Logger.new('/dev/null') # Fix Hashie bug warning

    bar_amnt = 6
    search_radius = 250
    increment = 100

    results = bars_get(night, bar_amnt, search_radius, increment)

    puts "Finishing getting the #{results['venues'].length} bars, now to create them"

    results['venues'].each do |result|
      name = result['name'].to_s
      lat = result['location']['lat'].to_s
      lng = result['location']['lng'].to_s
      address = result['location']['formattedAddress'].join(', ')
      category = result['categories'].first['name'].to_s
      foursquare_id = result['id'].to_s
      photo = photo_get(foursquare_id)
      hours = hours_get(foursquare_id)
      open = hours['start']
      close = hours['end']

      puts "Creating bar #{name}. Address: #{address}"
      Bar.create!(
        name: name, lat: lat, lng: lng, address: address, category: category,
        night: night, foursquare_id: foursquare_id, photo: photo, open: open,
        close: close
      )
    end
  end

  private

  def self.client
    Foursquare2::Client.new(:client_id => ENV['FOURSQUARE_PUBLIC_KEY'], :client_secret => ENV['FOURSQUARE_SECRET_KEY'])
  end

  def self.bars_get(night, amnt, radius, increment)
    puts "Looking for #{amnt} bars in a #{(radius/1_000.0).round(2)}km radius"
    results = client.search_venues(:ll => "#{night.lat}, #{night.lng}", :radius => radius, :limit => amnt, :categoryId => '4bf58dd8d48988d116941735,50327c8591d4c4b30a586d5d,4bf58dd8d48988d121941735', :v => '20190827').to_hash
    print_results(results)

    return results if radius > 100_000
    multiplier = 1.2
    multiplier = 1.5 if radius >= 1_500
    multiplier = 3 if radius >= 20_000

    if results['venues'].length < amnt
      sleep 0.5 # Maximum 2 QPS, so sleeping just to make sure
      return bars_get(night, amnt, radius + increment, increment * multiplier)
    end

    puts "#{results['venues'].length}"
    results
  end

  def self.photo_get(foursquare_id)
    begin
      photo_response = client.venue_photos(foursquare_id, :v => '20190827').to_hash
    rescue Foursquare2::APIError
      puts "API Quota exceeded... (Photo request)"
      return ""
    end

    if photo_response['items'].any?
      photo_hash = photo_response['items'].first
      return photo_hash['prefix'] + '512x512' + photo_hash['suffix']
    end

    ""
  end

  def self.print_results(results)
    puts "#{results['venues'].length} bars found"
    results['venues'].each do |result|
      name = result['name'].to_s
      address = result['location']['formattedAddress'].join(', ')
      puts "Bar: #{name} Address: #{address}"
    end
  end

  def self.hours_get(foursquare_id)
    begin
      hours_response = client.venue_hours(foursquare_id, :v => '20190827').to_hash
    rescue Foursquare2::APIError
      puts "API Quota exceeded... (Hours request)"
      return ""
    end

    return hours_response['hours']['timeframes'][0]['open'][0] if hours_response['hours'].any?

    ""
  end
end
