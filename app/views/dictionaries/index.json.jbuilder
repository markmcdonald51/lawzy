json.array!(@dictionaries) do |dictionary|
  json.extract! dictionary, :id, :name, :description, :edition, :position
  json.url dictionary_url(dictionary, format: :json)
end
