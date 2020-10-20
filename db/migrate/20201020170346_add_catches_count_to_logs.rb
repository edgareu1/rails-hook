class AddCatchesCountToLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :logs, :catches_count, :integer, default: 0
  end
end
