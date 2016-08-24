require 'test_helper'

class TermSearchLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @term_search_log = term_search_logs(:one)
  end

  test "should get index" do
    get term_search_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_term_search_log_url
    assert_response :success
  end

  test "should create term_search_log" do
    assert_difference('TermSearchLog.count') do
      post term_search_logs_url, params: { term_search_log: { term_id: @term_search_log.term_id, user_id: @term_search_log.user_id } }
    end

    assert_redirected_to term_search_log_url(TermSearchLog.last)
  end

  test "should show term_search_log" do
    get term_search_log_url(@term_search_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_term_search_log_url(@term_search_log)
    assert_response :success
  end

  test "should update term_search_log" do
    patch term_search_log_url(@term_search_log), params: { term_search_log: { term_id: @term_search_log.term_id, user_id: @term_search_log.user_id } }
    assert_redirected_to term_search_log_url(@term_search_log)
  end

  test "should destroy term_search_log" do
    assert_difference('TermSearchLog.count', -1) do
      delete term_search_log_url(@term_search_log)
    end

    assert_redirected_to term_search_logs_url
  end
end
