require 'rails_helper'

RSpec.describe Fetch, type: :model do
  it 'fetches n number of videos from channel' do
    # using sony music channel id
    channel_id = 'UC56gTxNs4f9xZ7Pa2i5xNzg'
    url = Fetch.channel_metadata_url(key: Rails.application.credentials.youtube_api_key, channelId: channel_id, publishedAfter: Date.new(2004,3,3).to_time.utc.iso8601)
    channel_videos = Fetch.channel_videos(url, 150, channel_id) 
    expect(channel_videos.values.flatten.compact.count).to be(150)
  end
end
