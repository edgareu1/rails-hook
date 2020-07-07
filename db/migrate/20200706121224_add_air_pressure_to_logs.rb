class AddAirPressureToLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :logs, :air_pressure, :integer
  end
end
