# spec/features/recipes_spec.rb
require 'rails_helper'

RSpec.feature "Recipes", type: :feature do
  let(:user) { create(:user) }

  before do
    # Sign in the user using Devise's sign_in helper
    sign_in user
  end

  scenario "User views own recipes list" do
    recipe = create(:recipe, user: user)
    visit recipes_path
    expect(page).to have_content(recipe.name)
    expect(page).to have_content(recipe.description)
  end

  # Removed the "User views public recipes list" scenario
  
  scenario "User views recipe details" do
    recipe = create(:recipe, user: user)
    visit recipe_path(recipe)
    expect(page).to have_content(recipe.name)
    expect(page).to have_content(recipe.description)
    expect(page).to have_content("Preparation Time: #{recipe.preparation_time}")
    expect(page).to have_content("Cooking Time: #{recipe.cooking_time}")
  end
  scenario 'User views the index page' do
    #visit recipes_path
    #expect(page).to have_content(‘My Recipes’)
    #expect(page).to have_link(‘Sample Recipe’, href: recipe_path(recipe))
    #expect(page).to have_content(‘Sample description’)
  end
end
