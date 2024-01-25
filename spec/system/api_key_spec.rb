# frozen_string_literal: true

require 'rails_helper'

describe 'user able to edit youtube api key', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }

  it 'shows api key to users' do
    sign_in user

    visit '/api_key'

    expect(page).to have_content(user.youtube_api_key.to_s)
  end

  it 'user able to edit api key' do
    sign_in user

    visit '/api_key/edit'
    expect(page).to have_field('user_youtube_api_key', with: 'randomstring')

    fill_in 'user_youtube_api_key', with: 'anotherrandomnumber'
    click_button 'Update'

    expect(page).to have_content('API Key successfully updated')
    expect(page).to have_content('anotherrandomnumber')
  end
end
