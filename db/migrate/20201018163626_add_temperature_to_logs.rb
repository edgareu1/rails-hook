class AddTemperatureToLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :logs, :temperature, :float
  end
end
