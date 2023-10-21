require 'rails_helper'
require 'capybara'

feature 'user', type: :feature, js: true do
  include Devise::Test::IntegrationHelpers

  setup do
    Capybara.current_driver = :selenium_chrome
  end

  let(:user) { create(:user) }

  it 'able to see fields' do
    sign_in user

    visit '/channels'

    click_link 'Add Channel'

    expect(page).to have_field('Channel ID').and have_field('Keywords').and have_field('Non Keywords')
      .and have_field('Published Before').and have_field('Published After').and have_field('Minimum Time(in s)')
      .and have_field('Maximum Time(in s)').and have_field('Videos')
  end

  it 'adds channel details' do
    sign_in user

    visit channels_path

    click_link 'Add Channel'

    fill_in 'Channel ID', with: 'abracadabra'
    fill_in 'Keywords', with: 'keyword1;keyword2'
    fill_in 'Non Keywords', with: 'nonkeyword1;nonkeyword2'
    fill_in 'Published Before', with: '02122022'
    fill_in 'Published After', with: '02112022'
    fill_in 'Minimum Time(in s)', with: 100
    fill_in 'Maximum Time(in s)', with: 1000
    select '50', :from => 'Videos'
    click_button 'Add'

    expect(page).to have_content('abracadabra').and have_content('keyword1;keyword2')
      .and have_content('nonkeyword1;nonkeyword2').and have_content('02 Dec 2022')
      .and have_content('02 Nov 2022').and have_content('00:01:40')
      .and have_content('00:16:40').and have_content('50')
  end

  it 'deletes channel' do
    filter = create(:filter)    
    channel = create(:channel, user: user, filter: filter)
    sign_in user 

    visit '/channels'

    expect(page).to have_content(channel.identifier)

    click_link 'Delete'
    page.accept_alert
    
    expect(page).to_not have_content(channel.identifier)
  end

  it 'edits channel details' do
    
    filter = create(:filter)    
    channel = create(:channel, user: user, filter: filter)
    sign_in user   

    visit channels_path

    click_link 'Edit'

    expect(page).to have_field('Channel ID', with: channel.identifier).and have_field('Keywords', with: filter.keywords)
      .and have_field('Non Keywords', with: filter.non_keywords).and have_field('Published Before', with: '2022-12-02')
      .and have_field('Minimum Time(in s)', with: filter.minimum_duration).and have_field('Maximum Time(in s)', with: filter.maximum_duration)
      .and have_field('Videos', with: filter.videos)

    fill_in 'Channel ID', with: 'abracadabra'
    fill_in 'Keywords', with: 'keyword1;keyword2'
    fill_in 'Non Keywords', with: 'nonkeyword1;nonkeyword2'
    fill_in 'Published Before', with: '02122022'
    fill_in 'Published After', with: '02112022'
    fill_in 'Minimum Time(in s)', with: 100
    fill_in 'Maximum Time(in s)', with: 1000
    select '50', :from => 'Videos'
    click_button 'Update'

    expect(page).to have_content('abracadabra').and have_content('keyword1;keyword2')
      .and have_content('nonkeyword1;nonkeyword2').and have_content('02 Dec 2022')
      .and have_content('02 Nov 2022').and have_content('00:01:40')
      .and have_content('00:16:40').and have_content('50')
  end
end
