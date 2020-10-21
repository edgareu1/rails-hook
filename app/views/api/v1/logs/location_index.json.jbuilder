json.array! @logs do |log|
  json.extract! log, :id, :tag_id

  json.time do
    json.start log.start_time
    json.end log.end_time
  end

  json.weather do
    json.icon log.weather_icon
    json.description log.weather_description
  end

  json.stats do
    json.fish_caught do
      json.num log.catches_count
      json.weight_gr log.catches_weight
    end
  end
end
