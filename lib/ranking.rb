require 'modules/moon-phase.rb'

class Ranking
  include MoonPhase

  def initialize(user)
    @user = user
  end

  def rank
    arr_location_logs = []

    @user.location_ids.each do |location_id|
      arr_logs = @user.logs.to_a.select { |log| log["location_id"] == location_id }

      arr_location_logs << arr_logs unless arr_logs.empty?
    end

    # Until this point: arr_location_logs is an array with arrays of logs with the same location (no empty locations)

    all_location_hash = {}
    all_location_stat_hash = {}

    arr_location_logs.each do |arr_logs|
      sum_location_hours = 0
      normalized_location_num_catches = 0
      normalized_location_gr_catches = 0

      arr_logs.each do |log|
        log_moon_phase_multiple = ((log.moon_phase - 0.5).abs * 2 * 0.8) + 1
        log_air_pressure_multiple = air_pressure_indicator(log.air_pressure)
        log_wind_speed_multiple = wind_speed_indicator(log.wind_speed)

        log_multiple = log_moon_phase_multiple * log_air_pressure_multiple * log_wind_speed_multiple

        log.catches.each do |catch|
          normalized_location_num_catches += catch.quantity / log_multiple
          normalized_location_gr_catches += catch.weight / log_multiple
        end

        sum_location_hours += (log.end_time - log.start_time)
      end

      sum_location_hours = sum_location_hours.fdiv(60 * 60).round(1)

      all_location_hash[arr_logs.first.location_id] = {
        num_per_hour: normalized_location_num_catches / sum_location_hours,
        gr_per_hour: normalized_location_gr_catches / sum_location_hours,
      }
    end

    all_location_hash.each do |k, v|
      weather_data = Rails.configuration.open_weather_api.current lon: Location.find(k).longitude , lat: Location.find(k).latitude

      log_moon_phase_multiple = ((get_moon_phase(Time.now) - 0.5).abs * 2 * 0.8) + 1
      log_air_pressure_multiple = air_pressure_indicator(weather_data["main"]["pressure"])
      log_wind_speed_multiple = wind_speed_indicator(weather_data["wind"]["speed"])

      log_multiple = log_moon_phase_multiple * log_air_pressure_multiple * log_wind_speed_multiple

      num_predicted_per_hour = v[:num_per_hour] * log_multiple
      gr_predicted_per_hour = v[:gr_per_hour] * log_multiple

      all_location_stat_hash[k] = {
        num_per_hour: v[:num_per_hour],
        gr_per_hour: v[:gr_per_hour],
        moon_phase_multiple: log_moon_phase_multiple,
        air_pressure_multiple: log_air_pressure_multiple,
        wind_speed_multiple: log_wind_speed_multiple,
        weather_icon: weather_data["weather"][0]["icon"],
        num_predicted_per_hour: num_predicted_per_hour,
        gr_predicted_per_hour: gr_predicted_per_hour,
        classification: (num_predicted_per_hour * 0.2) + ((gr_predicted_per_hour / 1000) * 0.8)
      }
    end

    return all_location_stat_hash
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
end
