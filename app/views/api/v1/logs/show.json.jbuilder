json.extract! @log, :id

json.location do
  json.id @log.location_id
  json.extract! @log.location, :spot

  json.address do
    json.extract! @log.location, :city, :country
  end

  json.extract! @log, :tag_id
end

json.time do
  json.start @log.start_time
  json.end @log.end_time
end

json.weather do
  json.icon @log.weather_icon
  json.description @log.weather_description
  json.extract! @log, :temperature, :air_pressure, :wind_speed, :moon_phase
end

json.stats do
  json.fish_caught do
    json.num @log.catches_count
    json.weight_gr @log.catches_weight
  end
end

json.user_notes do
  json.extract! @log, :rating, :observation
end

json.instance_info do
  json.extract! @log, :created_at, :updated_at
end
