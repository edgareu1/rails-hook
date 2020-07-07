class AddUrlToFish < ActiveRecord::Migration[6.0]
  def change
    add_column :fish, :url, :string
  end
end
