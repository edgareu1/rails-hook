class AddPictureUrlToFish < ActiveRecord::Migration[6.0]
  def change
    add_column :fish, :picture_url, :string
  end
end
