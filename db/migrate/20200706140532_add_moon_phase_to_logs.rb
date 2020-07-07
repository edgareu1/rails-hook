class AddMoonPhaseToLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :logs, :moon_phase, :float
  end
end
