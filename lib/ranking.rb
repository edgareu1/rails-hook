class Ranking
  def initialize(user)
    @user = user
  end

  def rank
    arr_locations = []

    @user.location_ids.each do |location_id|
      arr_location_logs = @user.logs.to_a.select { |log| log["location_id"] == location_id }

      arr_locations << arr_location_logs unless arr_location_logs.empty?
    end

    # Until this point: arr_locations is an array with arrays of logs with the same location (no empty locations)

    all_ranking_hash = {}
    top_ranking_hash = {}

    arr_locations.each do |location|
      sum_location_classification = 0
      sum_location_hours = 0
      sum_location_num_catches = 0
      sum_location_weight_catches = 0

      location.each do |log|
        sum_num_catches = 0
        sum_gr_catches = 0

        log.catches.each do |catch|
          sum_num_catches += catch.quantity
          sum_gr_catches += catch.weight
        end

        sum_location_classification += ranking_log(sum_num_catches, sum_gr_catches, log.moon_phase, air_pressure_indicator(log.air_pressure), wind_speed_indicator(log.wind_speed))
        
        sum_location_hours += (log.end_time - log.start_time).fdiv(60 * 60).round(1)
        sum_location_num_catches += sum_num_catches
        sum_location_weight_catches += sum_gr_catches
      end

      all_ranking_hash[location.first.location_id] = {
        classification: sum_location_classification / sum_location_hours,
        number_hour: sum_location_num_catches / sum_location_hours,
        weight_hour: sum_location_weight_catches / sum_location_hours,
      }
    end

    
    top_ones = all_ranking_hash.delete_if { |k, v| v[:classification].zero? }.each do |k, v|
      weather_data = Rails.configuration.open_weather_api.current lon: Location.find(k).longitude , lat: Location.find(k).latitude

      top_ranking_hash[k] = {
        classification: v[:classification],
        number_hour: v[:number_hour],
        weight_hour: v[:weight_hour],
        moon_phase: ( ( (moon_calculation(Time.now, Time.now + (5 * 60 * 60)) - 0.5).abs * 0.8 * 2) + 1 ),
        air_pressure_indicator: air_pressure_indicator(weather_data["main"]["pressure"]),
        wind_speed_indicator: wind_speed_indicator(weather_data["wind"]["speed"]),
        weather_icon: weather_data["weather"][0]["icon"]
      }
    end

    return top_ranking_hash
  end

  def moon_calculation(start_time, end_time)
    new_moon_base = Time.new(2020, 06, 21, 6, 41, 00)
    moon_cycle = 29.5 * 60 * 60 * 24
    average_time = start_time + ((end_time - start_time) / 2)

    time_past_new_moon = (average_time - new_moon_base) % moon_cycle
    moon_percentage = (time_past_new_moon / moon_cycle)

    if moon_percentage < 0.5
      return moon_percentage * 2
    else
      return (1 - moon_percentage) * 2
    end
  end

  def air_pressure_indicator(air_pressure)
    if air_pressure <= 990
      return 0.5
    elsif air_pressure <= 1000
      return 0.9
    elsif air_pressure <= 1015
      return 1
    elsif air_pressure <= 1025
      return 0.6
    else
      return 0.3
    end
  end

  def wind_speed_indicator(wind_speed)
    if wind_speed <= 2
      return 0.5
    elsif wind_speed <= 5
      return 1
    elsif wind_speed <= 8
      return 0.8
    else
      return 0.5
    end
  end

  def ranking_log(num_catches, weight_catches, moon_phase, air_pressure, wind_speed)
    return  ( (num_catches * 0.2) + (weight_catches * 0.8) ).fdiv( ( ( (moon_phase - 0.5).abs * 0.8 * 2) + 1 ) * air_pressure * wind_speed)
  end
end
