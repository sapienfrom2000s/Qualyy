require 'faraday'

class YoutubeapiCallToFetchChannelMetadataJob < ApplicationJob
  queue_as :default

  attr_reader :list

  after_perform do
    FetchvideometadataJob.perform_later(list.flatten, current_user)
  end

  def perform(current_user)
    @current_user = current_user
    @list = []  
    current_user.channels.each do |channel|
      begin
        publishedAfter = channel.published_after ? channel.published_after.to_time.utc.iso8601 : Time.at(0).utc.iso8601
        publishedBefore = channel.published_before ? channel.published_before.to_time.utc.iso8601 : Time.now.utc.iso8601
        video_list = Youtube::Channel.videos(channel.no_of_videos, channelId: channel.identifier,
          publishedAfter: , publishedBefore: , key: current_user.youtube_api_key,
          )
      @list << video_list
      rescue => exception
        puts exception #broadcast exception with red
      end
      @list.each do |channels|
        channels.each  do |channel_id, videos|
          videos.each do |video_id|
            video_data = Youtube::Video.metadata(video_id, current_user.youtube_api_key)
            channel = current_user.channels.where(identifier: channel_id)
            duration = ActiveSupport::Duration.parse(video_data['duration']).to_i
            next unless duration.between?(channel.first.minimum_duration, channel.first.maximum_duration)
            video_title = StringUtils.new(video_data['title'])
            next unless video_title.keywords_present?(channel.first.keywords.split(' '))
            next unless video_title.keywords_absent?(channel.first.keywords.split(' '))
            dislikes = Youtube::Video.dislikes(video_id)
            video = Video.new(identifier: video_id, channel_id: , duration: , title: video_title.string,
             views: video_data['viewCount'].to_i, comments: video_data['commentCount'].to_i,
             likes: video_data['likeCount'].to_i, dislikes: dislikes, rating: video_data['likeCount'].to_i/dislikes,
             published_on: video_data['publishedAt'])
            video.save
          end
        end
      end
    end
  end
end
