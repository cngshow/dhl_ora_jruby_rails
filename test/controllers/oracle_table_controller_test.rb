require 'test_helper'

class OracleTableControllerTest < ActionController::TestCase
  test "should get list_tables" do
    get :list_tables
    assert_response :success
  end

end
