require 'test_helper'

class TermsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @term = terms(:one)
  end

  test "should get index" do
    get terms_url
    assert_response :success
  end

  test "should get new" do
    get new_term_url
    assert_response :success
  end

  test "should create term" do
    assert_difference('Term.count') do
      post terms_url, params: { term: { definition: @term.definition, dictionary_id: @term.dictionary_id, name: @term.name, parent_id: @term.parent_id, position: @term.position } }
    end

    assert_redirected_to term_path(Term.last)
  end

  test "should show term" do
    get term_url(@term)
    assert_response :success
  end

  test "should get edit" do
    get edit_term_url(@term)
    assert_response :success
  end

  test "should update term" do
    patch term_url(@term), params: { term: { definition: @term.definition, dictionary_id: @term.dictionary_id, name: @term.name, parent_id: @term.parent_id, position: @term.position } }
    assert_redirected_to term_path(@term)
  end

  test "should destroy term" do
    assert_difference('Term.count', -1) do
      delete term_url(@term)
    end

    assert_redirected_to terms_path
  end
end
