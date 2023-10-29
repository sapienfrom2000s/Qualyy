require 'rails_helper'

RSpec.describe Youtube, type: :model do
  describe '::Channel' do
    it 'fetches n number of videos from a channel' do
      # using sony music channel id
      channel_id = 'UC56gTxNs4f9xZ7Pa2i5xNzg'
      videos = Youtube::Channel.videos(150, key: Rails.application.credentials.youtube_api_key, channelId: channel_id, publishedAfter: Date.new(2004,3,3).to_time.utc.iso8601)
      expect(videos.values.flatten.compact.count).to be(150)
    end
  end

  describe '::Video' do
    it 'fetches metadata of a video' do
      metadata = Youtube::Video.metadata('jNQXAC9IVRw')
      expect(metadata.keys).to include('publishedAt', 'title', 'duration', 'viewCount', 'likeCount', 'commentCount')
    end
  end
end
