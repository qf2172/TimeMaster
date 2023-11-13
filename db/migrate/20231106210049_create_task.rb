class CreateTask < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :due_date
      t.string :description
      t.integer :difficulty
    end
  end
end
