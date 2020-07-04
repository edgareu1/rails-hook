class AddTagIdToLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :logs, :tag_id, :integer
  end
end
