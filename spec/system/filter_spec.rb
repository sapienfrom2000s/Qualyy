require 'rails_helper'

RSpec.describe 'Filter', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:album1) { create(:album, user: user1) }
  let(:channel1){ create(:channel, user: user1, album: album1) }

  it 'wrt views', js: true do
    video1 = create(:video, channel: channel1)
    video2 = create(:video, channel: channel1)
    video3 = create(:video, channel: channel1)
    video4 = create(:video, channel: channel1)
    video5 = create(:video, channel: channel1)
    video6 = create(:video, channel: channel1)

    sign_in user1
    visit album_videos_path(album1)

    page.current_window.resize_to(1600, 900)

    click_on 'Filter'
    
    fill_in id: 'min-views', with: video2.views/1_000_000
    fill_in id: 'max-views', with: video5.views/1_000_000

    click_on 'Apply'

    expect(page).to_not have_content('1.0M')
    expect(page).to_not have_content('6.0M')
  end

  it 'reset', js: true do
    video1 = create(:video, channel: channel1)
    video2 = create(:video, channel: channel1)
    video3 = create(:video, channel: channel1)
    video4 = create(:video, channel: channel1)
    video5 = create(:video, channel: channel1)
    video6 = create(:video, channel: channel1)

    sign_in user1
    visit album_videos_path(album1)

    page.current_window.resize_to(1600, 900)

    save_and_open_screenshot

    click_on 'Filter'
    save_and_open_screenshot
    
    fill_in id: 'min-views', with: video2.views/1_000_000
    fill_in id: 'max-views', with: video5.views/1_000_000

    click_on 'Apply'

    expect(page).to_not have_content("#{(video1.views.to_f/1_000_000).round(2)}M")
    expect(page).to_not have_content("#{(video6.views.to_f/1_000_000).round(2)}M")

    click_on 'Filter'
    click_on 'Reset'

    expect(page).to have_content("#{(video1.views.to_f/1_000_000).round(2)}M")
    expect(page).to have_content("#{(video6.views.to_f/1_000_000).round(2)}M")
  end
end
