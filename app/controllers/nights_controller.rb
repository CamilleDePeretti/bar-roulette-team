class NightsController < ApplicationController
  def show
    @midpoints = [[52.520008, 13.404954]]
    @markers = @midpoints.map do |midpoint|
      {
        lat: midpoint[0],
        lng: midpoint[1]
        # infoWindow: render_to_string(partial: "info_window", locals: { night: night})
      }
    end
  end
end
