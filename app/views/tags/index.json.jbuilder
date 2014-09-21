json.array!(@tags) do |tag|
  json.extract! tag, :id, :name, :category
  json.url tag_url(tag, format: :json)
end
