require 'rails_helper'

RSpec.describe Fetch, type: :model do
  it 'fetches n number of videos from channel' do
    # using sony music channel id
    channelid = 'UC56gTxNs4f9xZ7Pa2i5xNzg'
    url = Fetch.channel_metadata_url(Rails.application.credentials.youtube_api_key, channelid)
    channel_videos = Fetch.channel_videos(url, 150, channelid) 
    expect(channel_videos.values.flatten.count).to be(150)
  end
end
