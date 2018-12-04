require 'test_helper'

class InventoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get inventories_show_url
    assert_response :success
  end

end
