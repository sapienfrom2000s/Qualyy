# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Youtube do
  describe '::Channel' do
    it 'fetches n number of videos from a channel' do
      # using sony music channel id
      channel_id = 'UC56gTxNs4f9xZ7Pa2i5xNzg'
      videos = Youtube::Channel.videos(150, key: Rails.application.credentials.youtube_api_key, channelId: channel_id,
                                            publishedAfter: Date.new(2004, 3, 3).to_time.utc.iso8601)
      expect(videos.values.flatten.compact.count).to be(150)
    end
  end

  describe '::Video' do
    it 'fetches metadata of a video' do
      # id for first video posted on youtube
      id = 'jNQXAC9IVRw'
      metadata = Youtube::Video.metadata(id, Rails.application.credentials.youtube_api_key)
      expect(metadata.keys).to include('publishedAt', 'title', 'duration', 'viewCount', 'likeCount', 'commentCount')
    end

    it 'fetches dislikes of a video' do
      id = 'jNQXAC9IVRw'
      dislikes = Youtube::Video.dislikes(id)
      expect(dislikes).to be >= 0
    end
  end
end
