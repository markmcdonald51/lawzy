json.array!(@irs_codes) do |irs_code|
  json.extract! irs_code, :id, :trans_code, :dr_cr_file, :title, :valid_doc_code, :remarks
  json.url irs_code_url(irs_code, format: :json)
end
