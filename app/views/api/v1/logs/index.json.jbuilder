json.array! @logs do |log|
  json.extract! log, :id

  json.location do
    json.spot log.location.spot
    json.extract! log, :tag_id
  end

  json.time do
    json.start log.start_time
    json.end log.end_time
  end

  json.weather do
    json.description log.weather_description
  end
end
