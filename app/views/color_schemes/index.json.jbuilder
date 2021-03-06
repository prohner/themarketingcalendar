json.array!(@color_schemes) do |color_scheme|
  json.extract! color_scheme, :id, :name, :foreground, :background
  json.url color_scheme_url(color_scheme, format: :json)
end
