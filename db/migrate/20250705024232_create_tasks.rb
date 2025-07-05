class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :task_name, null: false
      t.text :description, null: false
      t.date :due_date
      t.integer :priority
      t.boolean :is_completed
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
