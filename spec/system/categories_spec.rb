require 'rails_helper'

RSpec.describe 'Category', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user1) { create(:user) }

  before(:each) do
    category1 = create(:category, user: user1)

    channel1 = create(:channel, category: category1, user: user1)
    channel2 = create(:channel, category: category1, user: user1)

    sign_in user1
    visit categories_path
  end

  it 'is/are listed to the current user' do
    expect(page).to have_content('Music_1').and have_content('Music_2')
  end

  it 'can be added by the current user' do
    click_on 'Add Category'
    fill_in 'category', :with => 'Movies'
    click_on 'Create Category'

    expect(page).to have_content('Movies')
  end

  it 'can be deleted by the current user' do
    click_on "delete_#{channel1.id}"
    page.accept_alert
    
    expect(page).not_to have_content('Music_1')
  end

  it 'can be edited by the current user' do
    click_on "edit_#{channel1.id}"
    fill_in 'category', :with => 'Rock_Music'
    click_on 'Update Category'
    
    expect(page).to have_content('Rock_Music')
  end
end
