class CreateFish < ActiveRecord::Migration[6.0]
  def change
    create_table :fish do |t|
      t.string :common_name
      t.string :scientific_name
      t.integer :legal_size
      t.float :legal_weight
      t.text :description

      t.timestamps
    end
  end
end
