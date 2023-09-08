require 'rails_helper'

feature 'fetch api data and show appropriate response', type: :system do
  include LoginHelper

  it 'shows warning if after applying filters, more than 100 videos gets requested' do
    User.create(email: 'bla@bla.com', password: 'password', youtube_api_key: 'arandomnumber', name: 'Bla')

    log_in_as('bla@bla.com')

    channel = Channel.create(identifier:'abracadabra')
    channel.filter = Filter.new(videos: 10)
    channel.user = User.first
    channel.save

    101.times
      video = Video.new(title:'something', duration: '00:23:22', published: 'today', rating: '99', link: 'something')
      video.user = User.first
      video.save
    end
    
    sleep 2

    visit '/channels'

    click_link 'Make Request'

    expect(page).to have_content("You currently have #{videos} videos.\n
      Make a stronger filter and bring it down to less than 100")
    end
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
