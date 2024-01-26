# rubocop:disable RSpec/ExampleLength
# frozen_string_literal: true

require 'rails_helper'
require 'capybara'

describe 'Channel', :js, type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:album) { create(:album, user:) }

  before do
    sign_in user
  end

  it 'is added', :js do
    visit album_path(album)

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

  it 'is deleted' do
    channel = create(:channel, album:)

    visit album_path(album)

    page.current_window.resize_to(1600, 900)
    click_link 'Delete'
    page.accept_alert

    expect(page).to have_no_content(channel.identifier)
  end

  it 'is updated', :js do
    channel = create(:channel, album:)

    visit album_path(album)
    page.current_window.resize_to(1600, 900)

    click_link "edit_channel_#{channel.id}"

    fill_in 'Channel ID', with: 'uabracadabra'
    fill_in 'Name', with: 'Channel Changed'
    fill_in 'Keywords', with: 'ukeyword1;keyword2'
    fill_in 'Non Keywords', with: 'unonkeyword1;nonkeyword2'
    fill_in 'Published Before', with: Date.new(2015, 1, 14)
    fill_in 'Minimum Time(in s)', with: 101
    select '100', from: 'No of videos'
    click_button 'Update'

    expect(page).to have_content('uabracadabra').and have_content('Channel Changed')
      .and have_content('ukeyword1;keyword2').and have_content('unonkeyword1;nonkeyword2')
      .and have_content('14 Jan 2015').and have_content('00:01:41').and have_content('100')
  end
end

# rubocop:enable RSpec/ExampleLength
