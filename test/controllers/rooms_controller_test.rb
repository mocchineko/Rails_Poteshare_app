require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get rooms_search_url
    assert_response :success
  end

end
