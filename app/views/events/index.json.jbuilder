json.array!(@events) do |event|
  json.extract! event, :id, :description, :start_date, :end_date, :campaign_id, :category_id, :repetition_type, :repetition_frequency, :on_sunday, :on_monday, :on_tuesday, :on_wednesday, :on_thursday, :on_friday, :on_saturday, :repetition_options
  json.url event_url(event, format: :json)
end
