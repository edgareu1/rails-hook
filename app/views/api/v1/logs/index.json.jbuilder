json.array! @logs do |log|
  json.extract! log, :id, :tag_id, :start_time, :end_time, :air_pressure, :wind_speed, :moon_phase, :weather_description, :weather_icon, :rating, :observation
end
