require 'rails_helper'

feature 'user able to see filters', type: :system do
  include LoginHelper

  it 'shows api key to users' do
    User.create(email: 'bla@bla.com', password: 'password', youtube_api_key: 'arandomnumber', name: 'Bla')

    log_in_as('bla@bla.com')

    sleep 2

    visit '/channels'

    expect(page).to have_field('Channel ID').and have_field('Keywords').and have_field('Non Keywords')
      .and have_field('Published Before').and have_field('Published After').and have_field('Minimum Duration')
      .and have_field('Maximum Duration')
  end
end
