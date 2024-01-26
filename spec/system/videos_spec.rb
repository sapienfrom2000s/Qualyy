# rubocop:disable RSpec/ExampleLength
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Videos', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:album) { create(:album, user:) }
  let(:channel) { create(:channel, album:) }

  it 'is listed' do
    video1 = create(:video, channel:)
    video2 = create(:video, channel:)
    video3 = create(:video, channel:)

    sign_in user
    visit album_videos_path(album)

    expect(page).to have_content(video1.title).and have_content(video2.title)
                .and have_content(video3.title)
  end
end

# rubocop:enable RSpec/ExampleLength
