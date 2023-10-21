require 'rails_helper'

feature 'user able to edit youtube api key', type: :system do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }

  it 'shows api key to users' do
    sign_in user

    visit '/api_key'

    expect(page).to have_content("Your API Key is '#{user.youtube_api_key}'")
  end

  it 'user able to edit api key' do
    sign_in user

    visit '/api_key/edit'
    expect(page).to have_field('Youtube api key', with: 'randomstring')

    fill_in 'Youtube api key', with: 'anotherrandomnumber'
    click_button 'Update'

    expect(page).to have_content('API Key successfully updated')
    expect(page).to have_content("Your API Key is 'anotherrandomnumber'")
  end
end
