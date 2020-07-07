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

    ranking_hash = {}

    arr_locations.each do |location|
      sum_location_classification = 0
      sum_location_hours = 0

      location.each do |log|
        sum_num_catches = 0
        sum_gr_catches = 0

        log.catches.each do |catch|
          sum_num_catches += catch.quantity
          sum_gr_catches += catch.weight
        end

        sum_location_classification += ranking_log(sum_num_catches, sum_gr_catches, log.moon_phase, air_pressure_indicator(log.air_pressure), wind_speed_indicator(log.wind_speed))
        sum_location_hours += (log.end_time - log.start_time).fdiv(60 * 60).round(1)
      end

      ranking_hash[location.first.location_id] = sum_location_classification / sum_location_hours
    end

    return ranking_hash
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
