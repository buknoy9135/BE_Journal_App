class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

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
      flash.now[:alert] = "Failed to create task. Please check the errors."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to category_task_path(@category, @task), notice: "Task successfully updated."
    else
      flash.now[:alert] = "Failed to update task. Please check the errors."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to category_tasks_path(@category), notice: "Task successfully deleted."
  end

  def toggle_complete
    @task = @category.tasks.find(params[:id])
    @task.update(is_completed: !@task.is_completed)
    redirect_back fallback_location: category_tasks_path(@category), notice: "Task status updated."
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

  def record_not_found
    redirect_to category_tasks_path(@category), alert: "Record does not exist."
    # redirect_back fallback_location: root_path, alert: "Record does not exist."
    # render file: Rails.root.join("public/404.html"), status: :not_found, layout: false
  end

  def invalid_foreign_key
    redirect_to @category, alert: "Unable to delete category. Category is still referenced to task(s)."
  end
end
