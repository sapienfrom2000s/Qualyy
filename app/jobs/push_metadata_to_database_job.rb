class PushMetadataToDatabaseJob < ApplicationJob
  queue_as :default

  def perform(list, current_user)
    current_user.videos.destroy_all
    list.each do |video|
      duration = ActiveSupport::Duration.parse(video['contentDetails']['duration'])
      identifier = video['id']
      published_on = Date.parse(video['snippet']['publishedAt'])
      title = video['snippet']['title']
      views = video['statistics']['viewCount']
      comments = video['statistics']['commentCount']
      dislikes = video['statistics']['dislikes']
      video = Video.new(identifier: identifier, duration: duration,
         published_on: published_on, title: title, views: views,
          comments: comments, dislikes: dislikes, rating:  )
      video.user = current_user
      video.save
    end
  end
end
