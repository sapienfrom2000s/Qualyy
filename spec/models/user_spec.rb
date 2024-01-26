# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:user) { create(:user) }

  it 'destroys associated albums and channels' do
    album = create(:album, user:)
    create(:channel, album:)
    create(:channel, album:)
    expect { user.destroy }.to change(Album, :count).by(-1)
                                                    .and change(Channel, :count).by(-2)
  end

  it 'destroys associated videos when album is destroyed' do
    album = create(:album, user:)
    channel = create(:channel, album:)
    create(:video, channel:)
    create(:video, channel:)
    expect { user.albums.first.destroy }.to change(Video, :count).by(-2)
  end
end
