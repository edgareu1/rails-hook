json.array! @logs do |log|
  json.extract! log, :id, :tag_id, :start_time, :end_time, :weather_description
end
