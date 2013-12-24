json.array!(@categories) do |category|
  json.extract! category, :id, :description, :company_id, :color
  json.url category_url(category, format: :json)
end
