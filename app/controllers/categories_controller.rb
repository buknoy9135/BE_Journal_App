class CategoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @categories = current_user.categories
  end

  def show
    @category = current_user.categories.find(params[:id])
    @category
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      redirect_to categories_path, notice: "Category was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = current_user.categories.find(params[:id])
  end

  def update
    @category = current_user.categories.find(params[:id])
    if @category.update(category_params)
      redirect_to category_path(@category), notice: "Category was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = current_user.categories.find(params[:id])
    @category.destroy

    redirect_to categories_path, notice: "Category was successfully deleted."
  end

  private
    def category_params
      params.require(:category).permit(:category_name, :description)
    end
end
