json.array! @locations do |location|
  json.extract! location, :id, :spot
  json.address location.name

  json.stats do
    json.num_logs location.logs_count

    json.fish_caught do
      json.num location.catch_count
      json.weight_gr location.catch_weight
    end
  end
end
