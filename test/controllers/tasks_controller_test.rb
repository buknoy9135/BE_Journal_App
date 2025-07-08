require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
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

    @task = Task.create!(task_name: "Complete Journal App", description: "Finish the project before deadline", category: @category)
  end

  test "should get index tasks" do
    get category_tasks_path(@category)
    assert_response :success
  end

  test "should get show task" do
    get category_task_path(@category, @task)
    assert_response :success
  end

  test "should get new task" do
    get new_category_task_path(@category)
    assert_response :success
  end

  test "should get create task with valid params" do
    post category_tasks_path(@category), params: { task: { task_name: "test task title", description: "test body" } }
    assert_response :redirect
  end

  test "should get edit task" do
    get edit_category_task_path(@category, @task)
    assert_response :success
  end

  test "should patch update task with valid params" do
    patch category_task_path(@category, @task), params: { task: { task_name: "test task title", description: "test body" } }
    assert_response :redirect
  end

  test "should delete task" do
    delete category_task_path(@category, @task)
    assert_response :redirect
  end
end
