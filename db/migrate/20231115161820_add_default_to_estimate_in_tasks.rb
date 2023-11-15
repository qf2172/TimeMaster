class AddDefaultToEstimateInTasks < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tasks, :estimate, from: nil, to: 0
  end
end
