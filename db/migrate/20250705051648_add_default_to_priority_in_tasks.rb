class AddDefaultToPriorityInTasks < ActiveRecord::Migration[7.2]
  def change
    change_column_default :tasks, :priority, from: nil, to: 2
  end
end
