json.array!(@repeating_events) do |repeating_event|
  json.extract! repeating_event, :id, :title, :starts_at, :ends_at, :all_day, :description, :repetition_type, :repetition_frequency, :on_sunday, :on_monday, :on_tuesday, :on_wednesday, :on_thursday, :on_friday, :on_saturday
  json.url repeating_event_url(repeating_event, format: :json)
end
