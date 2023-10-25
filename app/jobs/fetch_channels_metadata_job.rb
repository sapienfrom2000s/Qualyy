class FetchChannelsMetadataJob < ApplicationJob
  queue_as :default

  def perform(user)
    video_ids = Fetch.channel_videos_batch(channel_ids)
    video_metadata_batch = Fetch.video_info_batch(video_ids)
    video_dislikes_batch = Fetch.video_dislikes_batch(video_ids)
  end
end
