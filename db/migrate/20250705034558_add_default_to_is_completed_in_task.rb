class AddDefaultToIsCompletedInTask < ActiveRecord::Migration[7.2]
  def change
    change_column_default :tasks, :is_completed, from: nil, to: false
  end
end
