json.array!(@terms) do |term|
  json.extract! term, :id, :name, :definition, :parent_id, :dictionary_id, :position
  json.url term_url(term, format: :json)
end
