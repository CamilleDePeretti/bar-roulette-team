class NightsController < ApplicationController
  def new
    @night = Night.new
    @address = Address.new
  end

  def create
    @night = Night.new
    @night.save
    params[:addresses].each do |address|
      Address.create(address: address, night: @night)
    end
    redirect_to new_night_path(@night)
  end

  def show
    @nights = [[52.520008, 13.404954]]
    @markers = @nights.map do |night|
      {
        lat: night[0],
        lng: night[1]
      }
    end
  end
end
