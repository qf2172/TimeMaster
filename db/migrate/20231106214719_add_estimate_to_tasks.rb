class AddEstimateToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :estimate, :integer
  end
end
