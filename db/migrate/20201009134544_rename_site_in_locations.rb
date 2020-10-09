class RenameSiteInLocations < ActiveRecord::Migration[6.0]
  def change
    rename_column :locations, :site, :spot
  end
end
