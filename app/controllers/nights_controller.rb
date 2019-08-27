class NightsController < ApplicationController
  def show
    @midpoints = [[52.520008, 13.404954]]
    @markers = @midpoints.map do |midpoint|
      {
        lat: midpoint[0],
        lng: midpoint[1]
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
