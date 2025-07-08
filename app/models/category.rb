class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, -> { order(:is_completed) }, dependent: :destroy

  validates :category_name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 3 }
end
