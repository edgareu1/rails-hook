json.array! @logs do |log|
  json.extract! log, :id

  json.location do
    json.extract! @location, :id, :spot
    json.extract! log, :tag_id
  end

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
