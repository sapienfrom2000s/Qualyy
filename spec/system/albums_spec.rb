# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Albums', type: :feature do
  include Devise::Test::IntegrationHelpers

  let(:user) { create(:user) }
  let(:album1) { create(:album, user:) }
  let(:album2) { create(:album, user:) }

  before do
    create(:channel, album: album1)
    create(:channel, album: album2)
    sign_in user
    visit albums_path
  end

  it 'is/are listed to the current user' do
    expect(page).to have_content(album1.name).and have_content(album2.name)
  end

  it 'can be added by the current user' do
    click_on 'Add Album'
    fill_in 'album_name', with: 'Movies'
    click_on 'Create Album'

    expect(page).to have_content('Movies')
  end

  it 'can be deleted by the current user' do
    click_on "delete_album_#{album1.id}"

    expect(page).to have_no_content(album1.name)
  end

  it 'can be edited by the current user' do
    click_on "edit_album_#{album1.id}"
    fill_in 'album_name', with: 'Rock_Music'
    click_on 'Update Album'

    expect(page).to have_content('Rock_Music')
  end
end
