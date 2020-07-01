class AddQuantityToCatches < ActiveRecord::Migration[6.0]
  def change
    add_column :catches, :quantity, :integer
  end
end
