json.array!(@campaigns) do |campaign|
  json.extract! campaign, :id, :description, :start_date, :end_date, :company_id, :color
  json.url campaign_url(campaign, format: :json)
end
