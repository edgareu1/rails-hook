module PredictionHelper
  require 'matrix'

  class Predictor
    include LinearRegressionHelper

    def initialize(user)
      # Reject Locations with less than 5 Logs (for statistical relevance)
      @locations = user.locations
                       .reject { |loc| loc.logs_count < 5 }
    end

    # Method that returns the prediction of weight of fish to be caught (per hour) at a certain Location
    def predict(location)
      x_data = []
      y_data = []

      location.logs.each do |log|
        weight_caught_hour = log.catches_weight.fdiv(log.duration)

        # Predicting weight of fish caught per hour
        y_data.push(weight_caught_hour)

        # Analysing 'temperature', 'air pressure', 'wind speed' and 'moon phase'
        x_data.push( [log.temperature, log.air_pressure, log.wind_speed, log.moon_phase.round(2)] )
      end

      linear_regression = RubyLinearRegression.new          # Create the regression model
      linear_regression.load_training_data(x_data, y_data)  # Load the training data
      linear_regression.train_normal_equation               # Train the model using the normal equation

      # Get the mean absolute percentage error of the model
      prediction_mean_error = linear_regression.mean_absolute_percentage_error

      # Get the current weather of the Location
      weather_data = location.weather_data
      prediction_data = [weather_data[:temperature], weather_data[:air_pressure], weather_data[:wind_speed], weather_data[:moon_phase]]

      # Get the prediction based on the trained model
      prediction_weight = linear_regression.predict(prediction_data).round
      prediction_weight = 0 if prediction_weight.negative?

      return { weather: weather_data,
               prediction: { weight_gr_hour:        prediction_weight,
                             mean_percentage_error: prediction_mean_error
                           }
             }
    end

    # Method that returns the Locations with the highest prediction of weight of fish to be caught
    # Arguments:
    #   num: Number of Locations to return
    def top_locations(num)
      @locations.map { |loc| { location: loc }.merge(predict(loc)) }
                .max_by(num) { |loc| [loc[:prediction][:weight_gr_hour], - loc[:prediction][:mean_percentage_error]] }
                .reject { |loc| loc[:prediction][:weight_gr_hour].zero? }
    end
  end
end
