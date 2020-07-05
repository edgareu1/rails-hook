class AddSiteToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :site, :string
  end
end
