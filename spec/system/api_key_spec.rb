# frozen_string_literal: true

require 'rails_helper'

describe 'Youtube API Key', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }

  before do
    sign_in user
    visit api_key_path
  end

  it 'is displayed' do
    expect(page).to have_content(user.youtube_api_key)
  end

  describe 'on edit page' do
    before { click_link 'Edit' }

    it 'is updated' do
      fill_in 'user_youtube_api_key', with: 'anotherrandomapikey'
      click_button 'Update'

      # do we need to test flash message and updation of key in different test cases

      expect(page).to have_content('anotherrandomapikey')
                  .and have_content('API Key successfully updated')
    end

    it 'is displayed on the text field' do
      expect(page).to have_field('user_youtube_api_key', with: user.youtube_api_key)
    end
  end
end
