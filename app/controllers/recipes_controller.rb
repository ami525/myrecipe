class RecipesController < ApplicationController
    before_action :require_user_logged_in
    before_action :correct_user, only: [:edit, :update, :destroy]
    
    
  def index
      @recipes = Recipe.all
  end

  def show
      @recipe = Recipe.find(params[:id])
  end

  def new
      @recipe = current_user.recipes.build
  end
  
    def create
      @recipe = current_user.recipes.build(recipe_params)
      
      if @recipe.save
          flash[:success] = 'レシピを登録しました。'
          redirect_to root_url
      else
          flash.now[:danger] = 'レシピは登録されませんでした。'
          render :new
      end 
    end      

  def edit
      @recipe = Recipe.find(params[:id])
  end

  def update
       #@recipe = correct_user.recipes.find(recipe_params)
      
      if @recipe.update(recipe_params)
          flash[:success] = 'レシピを更新しました。'
          redirect_to root_url
      else
          flash.now[:danger] = 'レシピが更新されませんでした'
         render :edit
      end     
  end

  def destroy
      #@recipe = correct_user.recipes.find(recipe_params)
      @recipe.destroy

      flash[:success] = 'レシピは正常に削除されました'
      #redirect_back(fallback_location: root_path)
      redirect_to root_url
  end

  
  private
  
  def recipe_params
    params.require(:recipe).permit(:title, :ingredient, :howto)
  end
  
  def correct_user
    @recipe = current_user.recipes.find_by(id: params[:id])
    unless @recipe
      redirect_to root_url
    end
  end
end
