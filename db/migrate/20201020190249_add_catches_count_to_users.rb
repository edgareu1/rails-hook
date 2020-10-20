class AddCatchesCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :catches_count, :integer, default: 0
  end
end
