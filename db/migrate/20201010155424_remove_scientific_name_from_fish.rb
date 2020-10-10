class RemoveScientificNameFromFish < ActiveRecord::Migration[6.0]
  def change
    remove_column :fish, :scientific_name
  end
end
