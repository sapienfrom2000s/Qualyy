require 'rails_helper'
# include './support/LoginHelper'

feature 'user able to edit youtube api key', type: :system do
  include LoginHelper
  it 'user able to edit api key' do
    User.create(email:'bla@bla.com', password: 'password', youtube_api_key: 'arandomnumber', name: 'Bla')

    log_in_as('bla@bla.com')

    sleep 2

    visit '/api_key/edit'
    expect(page).to have_field('Api Key', with: 'arandomnumber')

    fill_in 'Api Key', with: 'anotherrandomnumber'
    click_button 'Update Key'

    expect(page).to have_content('Your Api Key is anotherrandomnumber')
  end

end