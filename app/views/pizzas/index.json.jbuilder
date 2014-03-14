json.array!(@pizzas) do |pizza|
  json.extract! pizza, :id, :name, :ingredients, :description, :price, :available, :image
  json.url pizza_url(pizza, format: :json)
end
