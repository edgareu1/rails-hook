class AddCatchesWeightToLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :logs, :catches_weight, :integer, default: 0
  end
end
