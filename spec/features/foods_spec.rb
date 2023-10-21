# spec/features/foods_spec.rb
require 'rails_helper'

RSpec.feature "Foods", type: :feature do
  let(:user) { create(:user) }

  before do
    # Simulates the authentication of a user
    sign_in user
  end

  describe 'Food List Page' do
    context 'when there are no foods' do
        it 'shows a message indicating no foods are available' do
            Food.delete_all
            visit foods_path
            expect(page).not_to have_css('tbody.table-body tr')
        end          
    end

    context 'when there are foods' do
      let!(:foods) { create_list(:food, 3, user: user) }

      it 'displays the list of foods' do
        visit foods_path
        foods.each do |food|
          expect(page).to have_content(food.name)
          expect(page).to have_content(food.measurement_unit)
          expect(page).to have_content(food.price)
          expect(page).to have_content(food.quantity)
        end
      end
    end
  end

  describe 'Adding a Food' do
    it 'allows user to add a new food' do
      visit new_food_path

      fill_in "Name", with: "NewFoodItem"
      select "grams", from: 'food_measurement_unit'
      fill_in "food[price]", with: 10.0
      fill_in "Quantity", with: 5
      click_on "Save food"

      expect(page).to have_content("NewFoodItem")
    end
  end

  describe 'Deleting a Food' do
    let!(:food_to_delete) { create(:food, name: 'FoodToDelete', user: user) }

    it 'allows user to delete a food' do
        visit foods_path
        within "tr", text: food_to_delete.name do
          click_on 'Delete'
        end
    
        # Check if the food name is no longer on the page
        expect(page).not_to have_content(food_to_delete.name, wait: 10)
    end
end
end
