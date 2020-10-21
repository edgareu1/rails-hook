json.array! @catches do |catch|
  json.extract! catch, :id

  json.fish do
    json.extract! catch.fish, :id, :name
  end

  json.stats do
    json.extract! catch, :quantity, :weight
  end
end
