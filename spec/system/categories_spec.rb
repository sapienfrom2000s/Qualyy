require 'rails_helper'

RSpec.describe 'Category', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user1) { create(:user) }
  let(:category1) { create(:category, user: user1) }
  let(:category2) { create(:category, user: user1) }
  let(:channel1) { create(:channel, category: category1, user: user1) }
  let(:channel2) { create(:channel, category: category2, user: user1) }

  before(:each) do
    # bad code, defied the purpose of lazy loading
    channel1 # touch
    channel2 # touch
    sign_in user1
    visit categories_path
  end

  it 'is/are listed to the current user' do
    expect(page).to have_content('Music_1').and have_content('Music_2')
  end

  it 'can be added by the current user' do
    click_on 'Add Category'
    fill_in 'category_name', :with => 'Movies'
    click_on 'Create Category'

    expect(page).to have_content('Movies')
  end

  it 'can be deleted by the current user' do
    click_on "delete_category_#{category1.id}"
    
    expect(page).not_to have_content('Music_1')
  end

  it 'can be edited by the current user' do
    click_on "edit_category_#{category1.id}"
    fill_in 'category_name', :with => 'Rock_Music'
    click_on 'Update Category'
    
    expect(page).to have_content('Rock_Music')
  end
end
