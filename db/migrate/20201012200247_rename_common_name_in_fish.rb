class RenameCommonNameInFish < ActiveRecord::Migration[6.0]
  def change
    rename_column :fish, :common_name, :name
  end
end
