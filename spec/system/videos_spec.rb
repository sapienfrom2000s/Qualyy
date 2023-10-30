require 'rails_helper'

RSpec.describe 'Videos', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user1) { create(:user) }
  let(:user2) { create(:user) }

  before(:each) do
    channel1 = create(:channel, user: user1)
    channel2 = create(:channel, user: user1)
    channel3 = create(:channel, user: user2)
    video1 = create(:video, channel: channel1)
    video2 = create(:video, channel: channel2)
    video3 = create(:video, channel: channel3)
  end

  it 'is listed to current user according to his channel settings' do
    sign_in user1
    visit videos_path

    expect(page).to have_content('randomtitle1').and have_content('randomtitle2').and have_content(90).and have_content(91).and have_content('02:02:02').and have_content('02:02:03').and have_content(1000).and have_content(1001).and have_content(20).and have_content(21)
    expect(page).to_not have_content('randomvideoid3')
  end
end
