class AddWeatherDescriptionToLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :logs, :weather_description, :string
  end
end
