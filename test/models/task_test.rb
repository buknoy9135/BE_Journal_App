require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(
      first_name: "Jalil",
      last_name: "Abulais",
      email: "jalil@example.com",
      password: "User@123",
      password_confirmation: "User@123"
    )

    @category = Category.create!(
      category_name: "Test Category",
      description: "A category for testing",
      user: @user
    )
  end
  test "should not save a task without a title" do
    task = Task.new(description: "test task description", category: @category)
    assert_not task.save
  end

  test "should not save a task without a body" do
    task = Task.new(task_name: "test task description", category: @category)
    assert_not task.save
  end

  test "should save a task even without a due_date" do
    task = Task.new(task_name: "test task description", description: "test task description", category: @category)
    assert task.save
  end

  test "should not save a task even without valid parameters" do
    task = Task.new(task_name: "test task description", category: @category)
    assert_not task.save
  end

  test "should not save task with past due_date" do
  task = Task.new(task_name: "Past task", description: "Test past date", due_date: Date.yesterday, category: @category)
  assert_not task.save
  end

  test "priority defaults to low if not set" do
    task = Task.new(task_name: "Default Priority: Low", description: "Should default: Low", category: @category)
    task.save
    assert_equal "low", task.priority
  end

  test "status defaults to false if not set" do
    task = Task.new(task_name: "No deadline", description: "Chill bro", category: @category)
    task.save
    assert_equal false, task.is_completed
  end
end
