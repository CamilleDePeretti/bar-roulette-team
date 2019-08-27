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
    redirect_to night_path(@night)
  end

  def show
    @night = Night.find(params[:id])
    @nights = [[52.5200, 13.404954]]
    @markers = @nights.map do |night|
      {
        lat: night[0],
        lng: night[1]
      }
    end
  end
end
