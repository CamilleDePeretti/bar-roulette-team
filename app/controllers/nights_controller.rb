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
      sleep 1
    end
    @night.save
    coords = MidpointService.geo_midpoint(@night.addresses)
    @night.lat = coords[0]
    @night.lng = coords[1]
    @night.save
    redirect_to night_path(@night)
  end

  def show
    @night = Night.find(params[:id])
    @nights = [[@night.lat, @night.lng]]
    @markers = @nights.map do |night|
      {
        lat: night[0],
        lng: night[1],
        infoWindow: render_to_string(partial: "info_window", locals: { night: night}),
        image_url: helpers.asset_url('logo.png')
      }
    # send the midpoint to foursquare
    # create radius around midpoint
    #retrieve 3 bars in the raidus
    #iterate over the 3 bars to display info
    end
    client = Foursquare2::Client.new(:client_id => 'TRIBS0HCJFDS3USY5MQ2Z2GSIOTK5H1E312LKTQBZIKAMYTT', :client_secret => '5ZKYIOJVB4NM44DQNFJR2MVGN1CW1OIBXSE1KI0NEQVIIPVM')
    @results = client.search_venues(:ll => "#{@night.lat}, #{@night.lng}", :radius => '250', :limit => '3', :categoryId => '4bf58dd8d48988d116941735', :v => '20190827')

  end
end
