require 'test_helper'

class LegalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @legal = legals(:one)
  end

  test "should get index" do
    get legals_url
    assert_response :success
  end

  test "should get new" do
    get new_legal_url
    assert_response :success
  end

  test "should create legal" do
    assert_difference('Legal.count') do
      post legals_url, params: { legal: { body: @legal.body, parent_id: @legal.parent_id, source: @legal.source, title: @legal.title } }
    end

    assert_redirected_to legal_path(Legal.last)
  end

  test "should show legal" do
    get legal_url(@legal)
    assert_response :success
  end

  test "should get edit" do
    get edit_legal_url(@legal)
    assert_response :success
  end

  test "should update legal" do
    patch legal_url(@legal), params: { legal: { body: @legal.body, parent_id: @legal.parent_id, source: @legal.source, title: @legal.title } }
    assert_redirected_to legal_path(@legal)
  end

  test "should destroy legal" do
    assert_difference('Legal.count', -1) do
      delete legal_url(@legal)
    end

    assert_redirected_to legals_path
  end
end
