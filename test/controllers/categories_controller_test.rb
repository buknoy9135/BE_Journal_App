require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = User.create!(
      first_name: "Jalil",
      last_name: "Abulais",
      email: "jalil@test.com",
      password: "Jalil@9135",
      password_confirmation: "Jalil@9135"
    )
    sign_in @user

    @category = Category.create!(category_name: "Work", description: "for Work related tasks", user: @user)
  end
  test "should get index category" do
    # sign_in User.create!(
    #   first_name: "Jalil",
    #   last_name: "Abulais",
    #   email: "jalil@test.com",
    #   password: "Jalil@9135",
    #   password_confirmation: "Jalil@9135"
    # )
    get categories_path
    assert_response :success
  end

  test "should show category" do
    get category_path(@category)
    assert_response :success
  end

  test "should get new category" do
    get new_category_path
    assert_response :success
  end

  test "should create a category with valid params" do
    post categories_path, params: { category: { category_name: "test title", description: "test body" } }
    assert_response :redirect
  end

  test "should get edit" do
    get edit_category_path(@category)
    assert_response :success
  end

  test "should patch update to category" do
    patch category_path(@category), params: { category: { category_name: "test title", description: "test body" } }
    assert_response :redirect
  end

  test "should delete a category" do
    delete category_path(@category)
    assert_response :redirect
  end
end
