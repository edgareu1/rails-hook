class AddCatchesCountToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :catches_count, :integer, default: 0
  end
end
