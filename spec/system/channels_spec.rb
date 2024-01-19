require 'rails_helper'
require 'capybara'

feature 'user', type: :feature, js: true do
  include Devise::Test::IntegrationHelpers

  let(:user1) { create(:user) }
  let(:album1) { create(:album, user: user1) }

  before(:each) do
    # bad code, defies the idea of lazy loading
    album1 #touch
  end

  it 'able to see fields' do
    sign_in user1

    visit album_path(album1)

    click_link 'Add Channel'

    expect(page).to have_field('Channel ID').and have_field('Name').and have_field('Keywords').and have_field('Non Keywords')
      .and have_field('Published Before').and have_field('Published After').and have_field('Minimum Time(in s)')
      .and have_field('Maximum Time(in s)').and have_field('No of videos')
  end

  it 'adds channel details', js: true do
    sign_in user1

    visit album_path(album1)

    click_link 'Add Channel'

    fill_in 'Channel ID', with: 'abracadabra'
    fill_in 'Name', with: 'Channel 1'
    fill_in 'Keywords', with: 'keyword1;keyword2'
    fill_in 'Non Keywords', with: 'nonkeyword1;nonkeyword2'
    fill_in 'Published Before', with: Date.new(2014, 01, 15)
    fill_in 'Minimum Time(in s)', with: 100
    fill_in 'Maximum Time(in s)', with: 1000
    select '50', from: 'No of videos'
    click_button 'Add'

    page.current_window.resize_to(1600, 900)

    expect(page).to have_content('abracadabra').and have_content('Channel 1')
    .and have_content('keyword1;keyword2').and have_content('nonkeyword1;nonkeyword2')
    .and have_content('15 Jan 2014').and have_content('00:01:40')
    .and have_content('00:16:40').and have_content('50')
  end

  it 'deletes channel' do
    channel = create(:channel, user: user1, album: album1)
    sign_in user1

    visit album_path(album1)

    expect(page).to have_content(channel.identifier)
    page.current_window.resize_to(1600, 900)
    click_link 'Delete'
    page.accept_alert

    expect(page).to_not have_content(channel.identifier)
  end

  it 'edits channel details', js: true do
    channel = create(:channel, user: user1, album: album1)
    sign_in user1

    visit album_path(album1)
    page.current_window.resize_to(1600, 900)

    click_link "edit_channel_#{channel.id}"

    fill_in 'Channel ID', with: 'abracadabra'
    fill_in 'Name', with: 'Channel Changed'
    fill_in 'Keywords', with: 'keyword1;keyword2'
    fill_in 'Non Keywords', with: 'nonkeyword1;nonkeyword2'
    fill_in 'Published Before', with: Date.new(2014, 1, 14)
    fill_in 'Minimum Time(in s)', with: 100
    fill_in 'Maximum Time(in s)', with: 1000
    select '50', from: 'No of videos'
    click_button 'Update'
    
    expect(page).to have_content('abracadabra').and have_content('Channel Changed')
      .and have_content('keyword1;keyword2').and have_content('nonkeyword1;nonkeyword2')
      .and have_content('14 Jan 2014').and have_content('00:16:40').and have_content('50')
  end
end
