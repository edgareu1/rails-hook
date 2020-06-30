class AddLogToCatches < ActiveRecord::Migration[6.0]
  def change
    add_reference :catches, :log, null: false, foreign_key: true
  end
end
