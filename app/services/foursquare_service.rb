class FoursquareService
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

  def self.photos_get(foursquare_id)
    begin
      photo_response = client.venue_photos(foursquare_id, :v => '20190827').to_hash
    rescue Foursquare2::APIError
      puts "API Quota exceeded... (Photo request)"
      return ""
    end

    if photo_response['items'].any?
      photos = photo_response['items'].map do |photo|
        photo['prefix'] + '512x512' + photo['suffix']
      end

      return photos
    end

    ""
  end

  def self.hours_get(foursquare_id)
    begin
      hours_response = client.venue_hours(foursquare_id, :v => '20190827').to_hash
    rescue Foursquare2::APIError
      puts "API Quota exceeded... (Hours request)"
      return ""
    end

    return hours_response['hours'] if hours_response['hours'].any?

    ""
  end

  def self.contact_get(foursquare_id)
    response = client.venue(foursquare_id, :v => '20190827').to_hash
    response['contact']
  end

  private

  def self.client
    Foursquare2::Client.new(:client_id => ENV['FOURSQUARE_PUBLIC_KEY'], :client_secret => ENV['FOURSQUARE_SECRET_KEY'])
  end

  def self.print_results(results)
    puts "#{results['venues'].length} bars found"
    results['venues'].each do |result|
      name = result['name'].to_s
      address = result['location']['formattedAddress'].join(', ')
      puts "Bar: #{name} Address: #{address}"
    end
  end
end
