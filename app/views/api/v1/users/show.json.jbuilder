json.extract! @user, :id, :username, :email

json.stats do
  json.extract! @user, :locations_count, :logs_count

  json.fish_caught do
    json.num @user.catch_count
    json.weight_gr @user.catch_weight
  end

  if @more_info
    json.top_fish @top_fish do |fish|
      json.id fish[:id]
      json.name fish[:name]

      json.catches do
        json.num fish[:catch_count]
        json.weight_gr fish[:catch_weight]
      end
    end

    json.top_locations @top_locations do |location|
      json.id location.id
      json.spot location.spot
      json.address location.name

      json.stats do
        json.num_logs location.logs_count

        json.fish_caught do
          json.num location.catch_count
          json.weight_gr location.catch_weight
        end
      end
    end
  end
end

json.instance_info do
  json.extract! @user, :created_at, :updated_at
end
