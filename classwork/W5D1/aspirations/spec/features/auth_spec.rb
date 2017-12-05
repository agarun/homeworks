# spec/features/auth_spec.rb

require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content('Sign Up')
  end

  feature 'signing up a user' do
    before(:each) do
      sign_up_jerry
    end
    
    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content('jerry')
    end
  end
end

feature 'logging in' do
  before(:each) do
    sign_in_jerry
  end
  
  scenario 'shows username on the homepage after login' do
    expect(page).to have_content('jerry')
  end

end

feature 'logging out' do  
  scenario 'begins with a logged out state' do
    visit new_user_url
    
    expect(page).to have_content('Sign Up')
    expect(page).to have_content('Sign In')
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    sign_in_jerry
    sign_out
    
    expect(page).to_not have_content('jerry')
  end
end