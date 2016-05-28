require 'test_helper'

class IrsCodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @irs_code = irs_codes(:one)
  end

  test "should get index" do
    get irs_codes_url
    assert_response :success
  end

  test "should get new" do
    get new_irs_code_url
    assert_response :success
  end

  test "should create irs_code" do
    assert_difference('IrsCode.count') do
      post irs_codes_url, params: { irs_code: { dr_cr_file: @irs_code.dr_cr_file, remarks: @irs_code.remarks, title: @irs_code.title, trans_code: @irs_code.trans_code, valid_doc_code: @irs_code.valid_doc_code } }
    end

    assert_redirected_to irs_code_path(IrsCode.last)
  end

  test "should show irs_code" do
    get irs_code_url(@irs_code)
    assert_response :success
  end

  test "should get edit" do
    get edit_irs_code_url(@irs_code)
    assert_response :success
  end

  test "should update irs_code" do
    patch irs_code_url(@irs_code), params: { irs_code: { dr_cr_file: @irs_code.dr_cr_file, remarks: @irs_code.remarks, title: @irs_code.title, trans_code: @irs_code.trans_code, valid_doc_code: @irs_code.valid_doc_code } }
    assert_redirected_to irs_code_path(@irs_code)
  end

  test "should destroy irs_code" do
    assert_difference('IrsCode.count', -1) do
      delete irs_code_url(@irs_code)
    end

    assert_redirected_to irs_codes_path
  end
end
