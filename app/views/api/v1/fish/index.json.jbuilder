json.array! @fish do |fish|
  json.extract! fish, :id, :name, :legal_size, :legal_weight, :good_weight
end
