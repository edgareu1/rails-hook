json.extract! @location, :id, :spot
json.address @location.name

json.coordinates do
  json.lat @location.latitude
  json.long @location.longitude
end

json.stats do
  json.num_logs @location.logs_count

  json.fish_caught do
    json.num @location.catch_count
    json.weight_gr @location.catch_weight
  end
end

json.instance_info do
  json.extract! @location, :created_at, :updated_at
end
