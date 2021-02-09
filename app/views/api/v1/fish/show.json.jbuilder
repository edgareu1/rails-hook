json.extract! @fish,
  :id,
  :name

json.more_info do
  json.extract! @fish,
    :url,
    :picture_url
end

json.legal_minimum do
  json.size_cm @fish.legal_size
  json.weight_gr @fish.legal_weight
end

json.good_catch do
  json.weight_gr @fish.good_weight
end
