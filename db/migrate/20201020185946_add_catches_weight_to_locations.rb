class AddCatchesWeightToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :catches_weight, :integer, default: 0
  end
end
