class PushMetadataToDatabaseJob < ApplicationJob
  queue_as :default

  def perform(list)
    # current_user.videos.destroy_all
    list.each do |video|
      duration = ActiveSupport::Duration.parse(video['items'][0]['contentDetails']['duration'])
      identifier = video['items'][0]['id']
      published_on = Date.parse(video['items'][0]['snippet']['publishedAt'])
      title = video['items'][0]['snippet']['title']
      views = video['items'][0]['statistics']['viewCount']
      comments = video['items'][0]['statistics']['commentCount']
      dislikes = video['items'][0]['statistics']['dislikes']
      video = Video.new(identifier: identifier, duration: duration,
         published_on: published_on, title: title, views: views,
          comments: comments, dislikes: dislikes )
      video.user = current_user
      video.save
    end
  end
end
