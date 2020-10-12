class AddLogsCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :logs_count, :integer, default: 0
  end
end
