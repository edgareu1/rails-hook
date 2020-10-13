json.array! @locations do |location|
  json.extract! location, :id, :spot, :logs_count
end
