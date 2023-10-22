require 'rails_helper'

RSpec.feature 'Recipes', type: :feature do
  scenario 'User views the index page' do
    recipe = create(:recipe, name: 'Sample Recipe', description: 'Sample description')
    visit recipes_path
    expect(page).to have_content('My Recipes')
    expect(page).to have_link('Sample Recipe', href: recipe_path(recipe))
    expect(page).to have_content('Sample description')
  end

  scenario 'User views the show page' do
    recipe = create(:recipe, name: 'Sample Recipe', description: 'Sample description')
    visit recipe_path(recipe)
    expect(page).to have_content('Sample Recipe')
    expect(page).to have_content('Sample description')
    # Add more expectations as needed
  end

  scenario 'User views the new recipe page' do
    visit new_recipe_path
    expect(page).to have_content('Create a new Recipe')
    # Add more expectations for the form fields
  end
end