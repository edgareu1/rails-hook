class AddWindSpeedToLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :logs, :wind_speed, :float
  end
end
