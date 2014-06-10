json.array!(@trips) do |trip|
  json.extract! trip, :id, :country_id, :description, :t_date
  json.url trip_url(trip, format: :json)
end
