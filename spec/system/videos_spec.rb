# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Videos', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:album1) { create(:album, user: user1) }
  let(:album2) { create(:album, user: user1) }

  it 'is listed to current user according to his channel settings' do
    channel1 = create(:channel, user: user1, album: album1)
    channel2 = create(:channel, user: user1, album: album1)
    channel3 = create(:channel, user: user2, album: album2)
    video1 = create(:video, channel: channel1)
    video2 = create(:video, channel: channel2)
    video3 = create(:video, channel: channel3)

    sign_in user1
    visit album_videos_path(album1)

    save_and_open_screenshot

    expect(page).to have_content(video1.title).and have_content(video2.title)
      .and have_content(90.0).and have_content(91.0).and have_content('02:02:02')
      .and have_content('02:02:03').and have_content("#{(video1.views.to_f / 1_000_000).round(2)}M")
      .and have_content("#{(video1.views.to_f / 1_000_000).round(2)}M")

    expect(page).to have_no_content(video3.title)
  end
end
