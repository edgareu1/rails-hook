json.extract! @location, :id, :spot
json.address @location.name

if @prediction[:prediction].nil?
  json.prediction "Needs at least 5 Logs to make a prediction."

elsif @prediction[:prediction][:weight_caught] <= 0
  json.prediction "The prediction gives a bad result."

else
  json.prediction do
    json.weight_caught_gr @prediction[:prediction][:weight_caught]
    json.extract! @prediction[:prediction], :percentage_error
  end
end

json.current_weather do
  json.extract! @prediction[:weather], :air_pressure, :wind_speed, :moon_phase
  json.description @prediction[:weather][:weather_description]
  json.icon @prediction[:weather][:weather_icon]
end
