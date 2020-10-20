class AddCatchesWeightToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :catches_weight, :integer, default: 0
  end
end
