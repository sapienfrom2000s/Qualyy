require 'rails_helper'
# include './support/LoginHelper'

feature 'user able to edit youtube api key', type: :system do
  include LoginHelper

  it 'shows api key to users' do
    User.create(email:'bla@bla.com', password: 'password', youtube_api_key: 'arandomnumber', name: 'Bla')

    log_in_as('bla@bla.com')

    sleep 2

    visit '/api_key'

    expect(page).to have_content("Your API Key is '#{User.first.youtube_api_key}'")
  end

  it 'user able to edit api key' do
    User.create(email:'bla@bla.com', password: 'password', youtube_api_key: 'arandomnumber', name: 'Bla')

    log_in_as('bla@bla.com')

    sleep 2

    visit '/api_key/edit'
    expect(page).to have_field('Youtube api key', with: 'arandomnumber')

    fill_in 'Youtube api key', with: 'anotherrandomnumber'
    click_button 'Update'

    sleep 2

    expect(page).to have_content('API Key successfully updated')
    expect(page).to have_content("Your API Key is '#{User.first.youtube_api_key}'")
  end

end