class BarCreationService
  def self.create_bars(night)
    Hashie.logger = Logger.new('/dev/null') # Fix Hashie bug warning

    bar_amnt = 6
    search_radius = 250
    increment = 100

    results = FoursquareService.bars_get(night, bar_amnt, search_radius, increment)

    puts "Finishing getting the #{results['venues'].length} bars, now to create them"

    results['venues'].each do |result|
      name = result['name'].to_s
      lat = result['location']['lat'].to_s
      lng = result['location']['lng'].to_s
      address = result['location']['formattedAddress'].join(', ')
      category = result['categories'].first['name'].to_s
      foursquare_id = result['id'].to_s
      photo = FoursquareService.photo_get(foursquare_id)
      hours = FoursquareService.hours_get(foursquare_id)
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

  def self.print_results(results)
    puts "#{results['venues'].length} bars found"
    results['venues'].each do |result|
      name = result['name'].to_s
      address = result['location']['formattedAddress'].join(', ')
      puts "Bar: #{name} Address: #{address}"
    end
  end
end
