class RecipesController < ApplicationController
#     # Devise for authentication
#     before_action :authenticate_user! 

# # association between User and Recipe models
#   def index
#     @recipes = current_user.recipes 
#   end


def index
    @recipes = Recipe.all
end


end
