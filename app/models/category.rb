class Category < ApplicationRecord
  belongs_to :user

  validates :category_name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 3 }
end
