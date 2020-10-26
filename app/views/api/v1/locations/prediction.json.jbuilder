if @prediction[:prediction].nil?
  json.prediction "We need at least 5 logs to make a prediction"

else
  json.prediction do
    json.extract! @prediction[:prediction], :weight_gr_hour, :mean_percentage_error
  end
end

json.current_weather do
  json.icon @prediction[:weather][:weather_icon]
  json.description @prediction[:weather][:weather_description]
  json.extract! @prediction[:weather], :temperature, :air_pressure, :wind_speed, :moon_phase
end
