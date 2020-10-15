class AddCityToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :city, :string
  end
end
