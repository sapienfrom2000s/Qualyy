require 'rails_helper'

RSpec.describe 'Album', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user1) { create(:user) }
  let(:album1) { create(:album, user: user1) }
  let(:album2) { create(:album, user: user1) }
  let(:channel1) { create(:channel, album: album1, user: user1) }
  let(:channel2) { create(:channel, album: album2, user: user1) }

  before(:each) do
    # bad code, defied the purpose of lazy loading
    channel1 # touch
    channel2 # touch
    sign_in user1
    visit albums_path
  end

  it 'is/are listed to the current user' do
    expect(page).to have_content('Music_1').and have_content('Music_2')
  end

  it 'can be added by the current user' do
    click_on 'Add Album'
    fill_in 'album_name', :with => 'Movies'
    click_on 'Create Album'

    expect(page).to have_content('Movies')
  end

  it 'can be deleted by the current user' do
    click_on "delete_album_#{album1.id}"
    
    expect(page).not_to have_content('Music_1')
  end

  it 'can be edited by the current user' do
    click_on "edit_album_#{album1.id}"
    fill_in 'album_name', :with => 'Rock_Music'
    click_on 'Update Album'
    
    expect(page).to have_content('Rock_Music')
  end
end
