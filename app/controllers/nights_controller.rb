class NightsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :show]

  def new
    @night = Night.new
    @address = Address.new
  end

  def create
    @night = Night.new
    params[:addresses].each do |address|
      Address.create(address: address, night: @night)
    end
    @night.save
    coords = MidpointHelper.geo_midpoint(@night.addresses)
    @night.lat = coords[0]
    @night.lng = coords[1]
    @night.save
    create_bars(@night)
    redirect_to night_path(@night)
  end

  def show
    @night = Night.find(params[:id])
    @markers = @night.bars.map do |bar|
    {
      lat: bar.lat,
      lng: bar.lng,
      infoWindow: render_to_string(partial: "info_window", locals: { bar: bar }),
      image_url: helpers.asset_url('beer-pin.png')
    }
    end
    @markers <<
    {
      lat: @night.lat, lng: @night.lng,
      infoWindow: render_to_string(partial: "info_window"),
      image_url: helpers.asset_url('midpoint-logo.png')
    }
  end

  private

  def create_bars(night)
    client = Foursquare2::Client.new(:client_id => 'TRIBS0HCJFDS3USY5MQ2Z2GSIOTK5H1E312LKTQBZIKAMYTT', :client_secret => ENV['FOURSQUARE_SECRET_KEY'])
    @results = client.search_venues(:ll => "#{@night.lat}, #{@night.lng}", :radius => '250', :limit => '3', :categoryId => '4bf58dd8d48988d116941735,50327c8591d4c4b30a586d5d,4bf58dd8d48988d121941735', :v => '20190827')
    @results.to_hash['venues'].each do |result|
      name = result['name'].to_s
      lat = result['location']['lat'].to_s
      lng = result['location']['lng'].to_s
      address = result['location']['formattedAddress'].join(', ')
      category = result['categories'].first['name'].to_s
      Bar.create(name: name, lat: lat, lng: lng, address: address, category: category, night: night)
    end
  end
end
