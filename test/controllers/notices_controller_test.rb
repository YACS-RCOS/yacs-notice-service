require 'test_helper'

class NoticesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @notice = Notice.create(message: "Hello world!", alert_type: "info", start_date: 1.day.ago, end_date: 1.day.from_now)
  end

  test "should get index" do
    get notices_url, as: :json
    assert_response :success
  end

  test "should create notice" do
    assert_difference('Notice.count') do
      post notices_url, params: { notice: { end_date: @notice.end_date, message: @notice.message, start_date: @notice.start_date, alert_type: @notice.alert_type } }, as: :json
    end
    json_response = JSON.parse(response.body)
    assert_equal "Hello world!", json_response["message"]
    assert_response 201
  end

  test "should show notice" do
    get notice_url(@notice), as: :json
    assert_response :success
  end

  test "should update notice" do
    patch notice_url(@notice), params: { notice: { end_date: @notice.end_date, message: "updated", start_date: @notice.start_date, alert_type: @notice.alert_type } }, as: :json
    @notice.reload
    assert_equal( @notice.message, "updated")
    assert_response 200
    json_response = JSON.parse(response.body)
    assert_equal "updated", json_response["message"]
  end

  test "should destroy notice" do
    assert_difference('Notice.count', -1) do
      delete notice_url(@notice), as: :json
    end

    assert_response 204
  end
end
