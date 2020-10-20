json.extract! @user, :id, :username, :email

json.stats do
  json.num_locations @user.locations_count
  json.num_logs @user.logs_count

  json.fish_caught do
    json.num @user.catches_count
    json.weight_gr @user.catches_weight
  end

  if @more_info
    json.top_fish @top_fish do |fish|
      json.id fish[:id]
      json.name fish[:name]

      json.catches do
        json.num fish[:catches_count]
        json.weight_gr fish[:catches_weight]
      end
    end

    json.top_locations @top_locations do |location|
      json.id location.id
      json.spot location.spot

      json.address do
        json.extract! location, :city, :country
      end

      json.stats do
        json.num_logs location.logs_count

        json.fish_caught do
          json.num location.catches_count
          json.weight_gr location.catches_weight
        end
      end
    end
  end
end

json.instance_info do
  json.extract! @user, :created_at, :updated_at
end
