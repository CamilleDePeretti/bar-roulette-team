class NightsController < ApplicationController
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
