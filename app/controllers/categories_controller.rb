class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: [ :show, :edit, :update, :destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    @categories = current_user.categories
    @todays_tasks = Task.joins(:category)
                        .where(categories: { user_id: current_user.id })
                        .where(due_date: Date.current, is_completed: false)
                        .order(:priority)
    @overdue_tasks = Task.joins(:category)
                         .where(categories: { user_id: current_user.id })
                         .where("due_date < ? AND is_completed = ?", Date.current, false)
    @tasks = Task.joins(:category)
                    .where(categories: { user_id: current_user.id })
  end

  def show
    @tasks = @category.tasks
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "Category was successfully created."
    else
      flash.now[:alert] = "Failed to create category. Please check the errors."
    render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @category.update(category_params)
      redirect_to category_path(@category), notice: "Category was successfully updated."
    else
      flash.now[:alert] = "Failed to update category. Please check the errors."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, notice: "Category was successfully deleted."
  end

  private

  def set_category
    @category = current_user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:category_name, :description)
  end

  def record_not_found
    redirect_to root_path, alert: "Record does not exist."
    # render file: Rails.root.join("public/404.html"), status: :not_found, layout: false
  end

  def invalid_foreign_key
    redirect_to @category, alert: "Unable to delete category. Category is still referenced to task(s)."
  end
end
