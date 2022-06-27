class Api::V1::RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]

  def index
    @recipes = Recipe.all.order(created_at: :desc)
    render json: @recipes
  end

  def create
    @recipe = Recipe.create!(recipe_params)
    if @recipe.save
      render json: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @recipe
  end

  def update
    if @recipe.update(recipe_params)
      render json: @recipe, status: :ok, location: api_v1_recipe_path(@recipe)
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
    render json: { message: 'Recipe deleted!' }
  end

  private

  def recipe_params
    # params.permit(:name, :image, :ingredients, :instruction)
    params.require(:recipe).permit(:name, :image, :ingredients, :instruction)
  end

  def recipe
    @recipe ||= Recipe.find(params[:id])
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
end
