json.extract! @log, :id, :tag_id

json.time do
  json.start @log.start_time
  json.end @log.end_time
end

json.weather do
  json.extract! @log, :air_pressure, :wind_speed, :moon_phase
  json.description @log.weather_description
  json.icon @log.weather_icon
end

json.stats do
  json.fish_caught do
    json.num @log.catch_count
    json.weight_gr @log.catch_weight
  end
end

json.user_notes do
  json.extract! @log, :rating, :observation
end

json.record_info do
  json.extract! @log, :created_at, :updated_at
end
