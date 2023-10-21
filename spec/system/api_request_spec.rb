require 'rails_helper'

feature 'fetch api data and show appropriate response', type: :system do
  include LoginHelper

  xit 'shows warning if after applying filters, more than 100 videos gets requested' do
    User.create(email: 'bla@bla.com', password: 'password', youtube_api_key: 'arandomnumber', name: 'Bla')

    log_in_as('bla@bla.com')

    channel = Channel.create(identifier:'abracadabra')
    channel.filter = Filter.new(videos: 10)
    channel.user = User.first
    channel.save

    allow(Video).to receive(:filter) do
      101.times do
        video = Video.new(identifier:'something', title:'something', duration: 45,
           views: 1000, comments: 1234)
        video.user = User.first
        video.save
      end
    end

    sleep 2

    visit '/channels'

    click_link 'Make Request'

    videos_count = 101
    expect(page).to have_content("Your request fetches #{videos_count} videos.Make a stronger filter and bring it down to less than 100")
  end

  xit 'shows list of videos if after applying filters, <= 100 videos gets requested' do
    User.create(email: 'bla@bla.com', password: 'password', youtube_api_key: 'arandomnumber', name: 'Bla')

    log_in_as('bla@bla.com')

    sleep 2

    visit '/channels'

    click_link 'Make Request'

    videos = 2

    User.first.videos.create

    if videos < 100
      expect(page).to have_content("You currently have #{videos} videos.\n
        Make a stronger filter and bring it down to less than 100")
    end
  end
end
