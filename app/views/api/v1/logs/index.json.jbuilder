json.array! @logs do |log|
  json.extract! log, :id

  json.time do
    json.start log.start_time
    json.end log.end_time
  end

  json.stats do
    json.fish_caught do
      json.num log.catch_count
      json.weight_gr log.catch_weight
    end
  end

  json.weather do
    json.icon log.weather_icon
    json.description log.weather_description
  end
end
