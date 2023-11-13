class ChangeStartTimeToDateInTasks < ActiveRecord::Migration[6.0]
  def up
    change_column :tasks, :start_time, :date
  end

  def down
    change_column :tasks, :start_time, :datetime
  end
end
