class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  def index
    @tasks = @category.tasks
  end

  def show
    @tasks = @category.tasks
  end

  def new
    @task = @category.tasks.new
  end

  def create
    @task = @category.tasks.new(task_params)
    if @task.save
      redirect_to category_task_path(@category, @task), notice: "Task successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to category_tasks_path(@category, @task), notice: "Task successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to category_tasks_path(@category), notice: "Task successfully deleted."
  end

  private

  def set_category
    @category = current_user.categories.find(params[:category_id])
  end

  def set_task
    @task = @category.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:task_name, :description, :due_date, :priority, :is_completed)
  end
end
