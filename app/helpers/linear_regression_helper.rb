module LinearRegressionHelper
  # This Class is based from the GitHub Repo "linear-regression" of "daugaard"; it was modified to
  # also calculate the mean absolute percentage error method
  class RubyLinearRegression
    attr_reader :x, :y, :theta, :mu, :sigma, :lambda

    def initialize
      @mu = 0
      @sigma = 1
    end

    # Method that loads and normalizes the training data; must be called prior to training.
    # Arguments:
    #   x_data: Two dimensional array with the independent variables of your training data
    #   y_data: Array with the dependent variables of your training data
    def load_training_data(x_data, y_data)
      # Normalize the x_data
      x_data = normalize_data(x_data)

      # Add 1 column to x_data
      x_data = x_data.map { |row| [1].concat(row) }

      # Build the x Matrix and y Vector
      @x = Matrix.rows(x_data)
      @y = Matrix.rows( y_data.collect { |i| [i] } )

      # Create a Matrix with one row and the same number of columns as the x_data
      # This variable will hold the normal equation formula
      @theta = Matrix.zero(@x.column_count, 1)
    end

    # Method that computes the mean absolute percentage error
    def mean_absolute_percentage_error
      prediction_y = (@x * @theta).to_a.flatten
      real_y = @y.to_a.flatten

      errors = 0

      prediction_y.size.times do |i|
        errors += (real_y[i] - prediction_y[i]).abs.fdiv(real_y[i]) unless real_y[i].zero?
      end

      result = (errors.fdiv(prediction_y.size) * 100)

      return result.round
    end

    # Method that calculates the optimal theta using the normal equation
    def train_normal_equation(lambda = 0)
      begin
        @lambda = lambda

        lambda_matrix = Matrix.build(@theta.row_size, @theta.row_size) do |col, row|
          ((col.zero? && row.zero?) || col != row) ? 0 : 1
        end

        # Calculate the optimal theta using the normal equation
        # theta = ( X' * X )^(-1) * X' * y
        @theta = (@x.transpose * @x + @lambda * lambda_matrix).inverse * @x.transpose * @y

        return @theta

      # If there's an error while manipulating the Matrices make the predicted weight zero
      rescue *Exception
        @sigma = [0, 0, 0]
      end
    end

    # Method that makes a prediction based on the trained model
    # Arguments:
    #   data: Array of independent variables to base the prediction on
    def predict(data)
      # Normalize the data
      data.each_index do |i|
        data[i] = (data[i] - @mu[i]) / @sigma[i].to_f
      end

      # Add 1 column to the prediction data
      data = [1].concat(data)

      # Perform prediction
      prediction = (Matrix[data] * @theta)[0, 0].to_f

      # If there's any error with the prediction make the predicted weight zero
      prediction = 0 if @sigma.include?(0) || @theta.any? { |i| !i.infinite?.nil? }

      return prediction
    end

    private

    def normalize_data(x_data)
      row_size = x_data.size
      column_count = x_data[0].is_a?(Array) ? x_data[0].size : 1

      x_norm = Array.new(row_size)
      @mu = Array.new(column_count)
      @sigma = Array.new(column_count)

      column_count.times do |column|
        column_data = x_data.map { |row| row[column] }
        @mu[column] = column_data.inject { |sum, i| sum + i } / row_size
        @sigma[column] = column_data.max - column_data.min
      end

      row_size.times do |row|
        row_data = x_data[row]
        x_norm[row] = Array.new(column_count)

        row_data.each_index do |i|
          x_norm[row][i] = (row_data[i] - @mu[i]) / @sigma[i].to_f
        end
      end

      return x_norm
    end
  end
end
