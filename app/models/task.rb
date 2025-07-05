class Task < ApplicationRecord
  belongs_to :category

  enum priority: { low: 2, medium: 1, high: 0 }

  validates :task_name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 3 }
  validates :due_date, comparison: { greater_than_or_equal_to: Date.today }, allow_blank: true
end
