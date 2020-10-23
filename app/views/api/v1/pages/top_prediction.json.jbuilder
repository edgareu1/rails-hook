json.array! @prediction do |loc_prediction|
  json.location_id loc_prediction[:location].id
  json.extract! loc_prediction[:location], :spot

  json.address do
    json.extract! loc_prediction[:location], :city, :country
  end

  json.prediction do
    json.extract! loc_prediction[:prediction], :weight_gr_hour, :mean_percentage_error
  end

  json.current_weather do
    json.icon loc_prediction[:weather][:weather_icon]
    json.description loc_prediction[:weather][:weather_description]
    json.extract! loc_prediction[:weather], :temperature, :air_pressure, :wind_speed, :moon_phase
  end
end
