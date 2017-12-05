
require 'spec_helper'
require 'rails_helper'

feature 'makes goals' do
  before(:each) do
    sign_in_jerry
  end

  scenario 'has a new goal page' do
    visit new_goal_url
    expect(page).to have_content('New Goal')
  end

  scenario 'makes a goal' do
    visit new_goal_url
    fill_in 'Goal', with: 'get bettererer'
    choose('goal[private]', option: 'true')

    # scenario 'submits the goal' do
    #   click_on 'Make Goal'
    # end
  end

  scenario 'submits a goal' do
    visit new_goal_url
    fill_in 'Goal', with: 'get bettererer'
    choose('goal[private]', option: 'true')
    click_on 'Make Goal'
  end
end
