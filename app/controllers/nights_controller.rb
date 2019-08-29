class NightsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :show]

  def new
    @night = Night.new
    @address = Address.new
  end

  def create
    @night = Night.new
    params[:addresses].select(&:present?).each do |address|
      Address.create(address: address, night: @night)
      sleep 1
    end
    @night.save
    coords = MidpointService.geo_midpoint(@night.addresses)
    @night.lat = coords[0]
    @night.lng = coords[1]
    @night.save
    BarCreationService.create_bars(@night)
    redirect_to night_path(@night)
  end

  def show
    @night = Night.find(params[:id])
    @markers = @night.bars[0..2].map do |bar|
      @bar_name = bar.name
      @bar_address = bar.address
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
end
