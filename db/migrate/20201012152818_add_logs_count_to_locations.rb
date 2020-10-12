class AddLogsCountToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :logs_count, :integer, default: 0
  end
end
