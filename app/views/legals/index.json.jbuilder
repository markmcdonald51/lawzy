json.array!(@legals) do |legal|
  json.extract! legal, :id, :title, :body, :parent_id, :source
  json.url legal_url(legal, format: :json)
end
