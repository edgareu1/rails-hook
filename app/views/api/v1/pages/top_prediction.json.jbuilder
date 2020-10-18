json.array! @prediction do |loc_prediction|
  json.extract! loc_prediction[:location], :id, :spot
  json.address loc_prediction[:location].name

  json.prediction do
    json.weight_gr loc_prediction[:prediction][:weight_caught]
    json.extract! loc_prediction[:prediction], :percentage_error
  end

  json.current_weather do
    json.icon loc_prediction[:weather][:weather_icon]
    json.description loc_prediction[:weather][:weather_description]
    json.extract! loc_prediction[:weather], :temperature, :air_pressure, :wind_speed, :moon_phase
  end
end