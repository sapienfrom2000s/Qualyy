require 'rails_helper'

feature 'user able to see filters', type: :system do
  include LoginHelper

  it 'shows api key to users' do
    User.create(email: 'bla@bla.com', password: 'password', youtube_api_key: 'arandomnumber', name: 'Bla')

    log_in_as('bla@bla.com')

    sleep 2

    visit '/channels'

    click_link 'Add Channel'

    expect(page).to have_field('Channel ID').and have_field('Keywords').and have_field('Non Keywords')
      .and have_field('Published Before').and have_field('Published After').and have_field('Minimum Time(in s)')
      .and have_field('Maximum Time(in s)').and have_field('Videos')
  end

  it 'remembers channels details that user added' do
    User.create(email: 'bla@bla.com', password: 'password', youtube_api_key: 'arandomnumber', name: 'Bla')

    log_in_as('bla@bla.com')

    sleep 2

    visit '/channels'

    click_link 'Add Channel'

    fill_in 'Channel ID', with: 'abracadabra'
    fill_in 'Keywords', with: 'keyword1;keyword2'
    fill_in 'Non Keywords', with: 'nonkeyword1;nonkeyword2'
    fill_in 'Published Before', with: '02122022'
    fill_in 'Published After', with: '02112022'
    fill_in 'Minimum Time(in s)', with: '100'
    fill_in 'Maximum Time(in s)', with: '1000'
    select '10', :from => 'videos'
    click_button 'Add'

    expect(page).to have_content('abracadabra').and have_content('keyword1;keyword2')
      .and have_content('nonkeyword1;nonkeyword2').and have_content('22 July 2022')
      .and have_content('22 April 2022').and have_content('00:01:40')
      .and have_content('00:16:20').and have_content('10')
  end
end
