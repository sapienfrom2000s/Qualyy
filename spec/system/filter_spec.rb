# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Filter', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:album) { create(:album, user:) }
  let(:channel) { create(:channel, album:) }

  before { sign_in user }

  it 'filters in videos for a given range of views', :js do
    create(:video, channel:, album:)
    video2 = create(:video, channel:, album:)
    create(:video, channel:, album:)
    create(:video, channel:, album:)
    video5 = create(:video, channel:, album:)
    create(:video, channel:, album:)

    visit album_videos_path(album)

    page.current_window.resize_to(1600, 900)

    click_on 'Filter'

    fill_in id: 'min-views', with: video2.views / 1_000_000
    fill_in id: 'max-views', with: video5.views / 1_000_000

    click_on 'Apply'

    expect(page).to have_no_content('1.0M')
                .and have_no_content('6.0M')
  end

  it 'resets the filters if a view range is given', :js do
    video1 = create(:video, channel:, album:)
    video2 = create(:video, channel:, album:)
    create(:video, channel:, album:)
    create(:video, channel:, album:)
    video5 = create(:video, channel:, album:)
    video6 = create(:video, channel:, album:)

    visit album_videos_path(album)

    page.current_window.resize_to(1600, 900)

    click_on 'Filter'

    fill_in id: 'min-views', with: video2.views / 1_000_000
    fill_in id: 'max-views', with: video5.views / 1_000_000

    click_on 'Apply'

    expect(page).to have_no_content("#{(video1.views.to_f / 1_000_000).round(2)}M")
    expect(page).to have_no_content("#{(video6.views.to_f / 1_000_000).round(2)}M")

    click_on 'Filter'
    click_on 'Reset'

    expect(page).to have_content("#{(video1.views.to_f / 1_000_000).round(2)}M")
    expect(page).to have_content("#{(video6.views.to_f / 1_000_000).round(2)}M")
  end
end
