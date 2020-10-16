module PredictionHelper
  require 'matrix'

  class Ranking
    include LinearRegressionHelper
    include MoonPhaseHelper

    def initialize(user)
      @user = user
      @moon_phase = round_element(get_moon_phase(Time.now))
      @locations = @user.locations
                        .reject { |loc| loc.logs_count < 5 }
    end

    def top_ranking_locations(num)
        @locations.map { |loc| { location: loc,
                                 prediction: prediction(loc)
                               }
                       }
                  .max_by(num) { |loc| loc[:prediction][:weight_caught] }
    end

    private

    def prediction(location)
      x_data = []
      y_data = []

      location.logs.each do |log|
        weight_caught_hour = log.catch_weight / log.duration

        # Predicting weight of fish caught per hour
        y_data.push(weight_caught_hour)

        # Analysing 'air pressure', 'wind speed' and 'moon phase'
        x_data.push( [log.air_pressure, round_element(log.wind_speed), round_element(log.moon_phase)] )
      end

      # Create the regression model
      linear_regression = RubyLinearRegression.new

      # Load the training data
      linear_regression.load_training_data(x_data, y_data)

      # Train the model using the normal equation
      linear_regression.train_normal_equation

      # Get the mean absolute percentage error of the model
      percentage_error = linear_regression.mean_absolute_percentage_error

      # Get the prediction based on the model
      weather_data = weather_data(location)

      prediction_data = [weather_data[:air_pressure], weather_data[:wind_speed], @moon_phase]

      prediction_weight = linear_regression.predict(prediction_data).round

      return { weight_caught: prediction_weight,
               percentage_error: percentage_error,
               weather_icon: weather_data[:weather_icon]
             }
    end

    def weather_data(location)
      weather_data = location.fetch_weather_data

      air_pressure = weather_data["main"]["pressure"]
      wind_speed = round_element(weather_data["wind"]["speed"])
      weather_icon = weather_data["weather"][0]["icon"]

      return { air_pressure: air_pressure, wind_speed: wind_speed, weather_icon: weather_icon }
    end

    def round_element(element)
      (element * 100).round
    end
  end
end
