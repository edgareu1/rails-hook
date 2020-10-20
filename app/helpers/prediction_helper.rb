module PredictionHelper
  require 'matrix'

  class Ranking
    include LinearRegressionHelper

    def initialize(user)
      @user = user

      # Reject Locations with less than 5 Logs
      @locations = @user.locations
                        .reject { |loc| loc.logs_count < 5 }
    end

    # Method that returns a prediction of the weight of fish to be caught (per hour) at a certain Location
    def prediction(location)
      x_data = []
      y_data = []

      location.logs.each do |log|
        weight_caught_hour = log.catches_weight.fdiv(log.duration)

        # Predicting weight of fish caught per hour
        y_data.push(weight_caught_hour)

        # Analysing 'temperature', 'air pressure', 'wind speed' and 'moon phase'
        x_data.push( [log.temperature, log.air_pressure, log.wind_speed, log.moon_phase.round(2)] )
      end

      # Create the regression model
      linear_regression = RubyLinearRegression.new

      # Load the training data
      linear_regression.load_training_data(x_data, y_data)

      # Train the model using the normal equation
      linear_regression.train_normal_equation

      # Get the mean absolute percentage error of the model
      percentage_error = linear_regression.mean_absolute_percentage_error

      # Get the current weather of the Location
      weather_data = location.weather_data

      prediction_data = [weather_data[:temperature], weather_data[:air_pressure], weather_data[:wind_speed], weather_data[:moon_phase]]

      # Get the prediction based on the trained model
      prediction_weight = linear_regression.predict(prediction_data).round

      return { weather: weather_data,
               prediction: { weight_caught:    prediction_weight,
                             percentage_error: percentage_error
                           }
             }
    end

    # Method that returns the Locations with the highest prediction of weight of fish to be caught
    # Arguments:
    #   num: Number of Locations to return
    def top_ranking_locations(num)
      @locations.map { |loc| { location: loc }.merge(prediction(loc)) }
                .select { |loc| loc[:prediction][:weight_caught].positive? }
                .max_by(num) { |loc| loc[:prediction][:weight_caught] }
    end
  end
end
