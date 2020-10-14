json.array! @logs do |log|
  json.extract! log, :id, :tag_id

  json.time do
    json.start log.start_time
    json.end log.end_time
  end

  json.weather do
    json.description log.weather_description
  end
end
