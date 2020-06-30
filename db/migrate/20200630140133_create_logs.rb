class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.timestamp :start_time
      t.timestamp :end_time
      t.integer :rating
      t.text :observation
      t.references :location, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
