class ChangeLegalWeightToIntegerInFish < ActiveRecord::Migration[6.0]
  def change
    change_column :fish, :legal_weight, :integer
  end
end
