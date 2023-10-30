class CreateTasks < ActiveRecord::Migration[6.0]
    def change
      create_table :tasks do |t|
        add_column :tasks, :due_date, :date
      end
    end
  end