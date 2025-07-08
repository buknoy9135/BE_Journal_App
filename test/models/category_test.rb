require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "should not save a category without a title" do
    category = Category.new(description: "test body")
    assert_not category.save
  end

  test "should not save a category without a body" do
    category = Category.new(category_name: "test category")
    assert_not category.save
  end

  test "should save a category with valid params" do
    user = User.create!(
    first_name: "Jalil",
    last_name: "Abulais",
    email: "jalil@example.com",
    password: "User@123",
    password_confirmation: "User@123"
  )
    category = Category.new(category_name: "test category", description: "test description", user: user)
    assert category.save
  end
end
