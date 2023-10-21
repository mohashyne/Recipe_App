require 'rails_helper'

RSpec.feature 'Home Page', type: :feature do
  scenario 'visiting the home page' do
    visit root_path
    expect(page).to have_content('Recipe App')
  end

  context 'when not signed in' do
    scenario 'user sees Sign In and Sign Up links' do
      visit root_path
      expect(page).to have_link('Sign In', href: new_user_session_path)
      expect(page).to have_link('Sign Up', href: new_user_registration_path)
    end

    scenario 'user does not see Sign Out link' do
      visit root_path
      expect(page).not_to have_link('Sign out', href: destroy_user_session_path)
    end
  end

  context 'when signed in' do
    let(:user) { create(:user) } # Assuming you're using FactoryBot

    background do
      login_as(user, scope: :user) # Sign in the user using Warden
    end
  end
end

RSpec.feature 'Home Page', type: :feature do
  scenario 'visiting the home page' do
    visit root_path
    expect(page).to have_content('Recipe App')
  end

  context 'when not signed in' do
    scenario 'user sees Sign In and Sign Up links' do
      visit root_path
      expect(page).to have_link('Sign In', href: new_user_session_path)
      expect(page).to have_link('Sign Up', href: new_user_registration_path)
    end

    scenario 'user does not see Sign Out link' do
      visit root_path
      expect(page).not_to have_link('Sign out', href: destroy_user_session_path)
    end
  end

  context 'when signed in' do
    let(:user) { create(:user) } # Assuming you're using FactoryBot

    background do
      login_as(user, scope: :user) # Sign in the user using Warden
    end
  end
end
