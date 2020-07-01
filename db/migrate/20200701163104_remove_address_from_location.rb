class RemoveAddressFromLocation < ActiveRecord::Migration[6.0]
  def change
    remove_column :locations, :address, :string
  end
end
