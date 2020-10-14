json.array! @fish do |fish|
  json.extract! fish, :id, :name

  json.more_info do
    json.extract! fish, :url, :picture_url
  end
end
