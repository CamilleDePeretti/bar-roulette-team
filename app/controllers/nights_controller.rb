class NightsController < ApplicationController
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
    redirect_to night_path(@night)
  end

  def show
    @night = Night.find(params[:id])
    @nights = [[@night.lat, @night.lng]]
    @markers = @nights.map do |night|
      {
        lat: night[0],
        lng: night[1]
        # infoWindow: render_to_string(partial: "info_window", locals: { night: night})
        # image_url: helpers.asset_url('REPLACE_THIS_WITH_YOUR_IMAGE_IN_ASSETS')
      }

    # send the midpoint to foursquare
    # create radius around midpoint
    #retrieve 3 bars in the raidus
    #iterate over the 3 bars to display info
    end
  end
end
