class AddWeatherIconToLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :logs, :weather_icon, :string
  end
end
