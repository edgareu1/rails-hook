json.extract! @location, :id, :spot
json.address @location.name

if @prediction[:prediction].nil?
  json.prediction "Needs at least 5 Logs to make a prediction."

else
  json.prediction do
    json.weight_gr @prediction[:prediction][:weight_caught].negative? ? 0 : @prediction[:prediction][:weight_caught]
    json.extract! @prediction[:prediction], :percentage_error
  end
end

json.current_weather do
  json.icon @prediction[:weather][:weather_icon]
  json.description @prediction[:weather][:weather_description]
  json.extract! @prediction[:weather], :air_pressure, :wind_speed, :temperature, :moon_phase
end
