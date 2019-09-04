class FoursquareService
  CATS = {
    all: '4bf58dd8d48988d116941735,50327c8591d4c4b30a586d5d,4bf58dd8d48988d121941735',
    beer: '4bf58dd8d48988d120941735,4bf58dd8d48988d11b941735,4bf58dd8d48988d116941735,50327c8591d4c4b30a586d5d,4bf58dd8d48988d11d941735,56aa371ce4b08b9a8d57356c',
    wine: '4bf58dd8d48988d1d5941735,4bf58dd8d48988d123941735',
    cocktail: '52e81612bcbc57f1066b7a0e,4bf58dd8d48988d11e941735,4bf58dd8d48988d1d5941735,4bf58dd8d48988d11c941735,4bf58dd8d48988d1d4941735,56aa371be4b08b9a8d57354d,4bf58dd8d48988d121941735',
    whisky: '4bf58dd8d48988d122941735',
    food: '4bf58dd8d48988d10d941735,4bf58dd8d48988d155941735,4bf58dd8d48988d11b941735',
    outdoor: '4bf58dd8d48988d117941735',
    queer: '4bf58dd8d48988d1d8941735',
    smoke: '4bf58dd8d48988d119941735,52e81612bcbc57f1066b7a0d,4bf58dd8d48988d117941735'
  }

  def self.bars_get(night, amnt, radius, increment, cat)
    puts "Looking for #{amnt} bars in a #{(radius/1_000.0).round(2)}km radius"
    results = client.search_venues(:ll => "#{night.lat}, #{night.lng}", :radius => radius, :limit => amnt, :categoryId => CATS[cat], :v => '20190827').to_hash
    print_results(results)

    return results if radius > 100_000
    multiplier = 1.2
    multiplier = 1.5 if radius >= 1_500
    multiplier = 3 if radius >= 20_000

    if results['venues'].length < amnt
      sleep 0.5 # Maximum 2 QPS, so sleeping just to make sure
      return bars_get(night, amnt, radius + increment, increment * multiplier, cat)
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

  def self.details_get(foursquare_id)
    begin
      response = client.venue(foursquare_id, :v => '20190827').to_hash
    rescue Foursquare2::APIError
      puts "API Quota exceeded... (Details request)"
      return ""
    end
    response
  end

  def self.contact_get(foursquare_id) # DEPRECATED
    begin
      response = client.venue(foursquare_id, :v => '20190827').to_hash
    rescue Foursquare2::APIError
      puts "API Quota exceeded... (Contact request)"
      return ""
    end
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
