require 'test_helper'

class PartsOfSpeechesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parts_of_speech = parts_of_speeches(:one)
  end

  test "should get index" do
    get parts_of_speeches_url
    assert_response :success
  end

  test "should get new" do
    get new_parts_of_speech_url
    assert_response :success
  end

  test "should create parts_of_speech" do
    assert_difference('PartsOfSpeech.count') do
      post parts_of_speeches_url, params: { parts_of_speech: { abbreviation: @parts_of_speech.abbreviation, description: @parts_of_speech.description, name: @parts_of_speech.name } }
    end

    assert_redirected_to parts_of_speech_url(PartsOfSpeech.last)
  end

  test "should show parts_of_speech" do
    get parts_of_speech_url(@parts_of_speech)
    assert_response :success
  end

  test "should get edit" do
    get edit_parts_of_speech_url(@parts_of_speech)
    assert_response :success
  end

  test "should update parts_of_speech" do
    patch parts_of_speech_url(@parts_of_speech), params: { parts_of_speech: { abbreviation: @parts_of_speech.abbreviation, description: @parts_of_speech.description, name: @parts_of_speech.name } }
    assert_redirected_to parts_of_speech_url(@parts_of_speech)
  end

  test "should destroy parts_of_speech" do
    assert_difference('PartsOfSpeech.count', -1) do
      delete parts_of_speech_url(@parts_of_speech)
    end

    assert_redirected_to parts_of_speeches_url
  end
end
