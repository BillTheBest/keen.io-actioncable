json.array!(@products) do |product|
  json.extract! product, :id, :price, :name, :description, :favorites
  json.url product_url(product, format: :json)
end
