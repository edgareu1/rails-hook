class AddGoodWeightToFish < ActiveRecord::Migration[6.0]
  def change
    add_column :fish, :good_weight, :integer
  end
end
