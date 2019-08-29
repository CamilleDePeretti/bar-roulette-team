require 'test_helper'

class NightsControllerTest < ActionDispatch::IntegrationTest

  # test "the truth" do
  #   assert true
  # end

  test "should get show" do
    get nights_show_url
    assert_response :success
  end
end
