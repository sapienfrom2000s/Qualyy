class PushMetadataToDatabaseJob < ApplicationJob
  queue_as :default

  def perform(list, current_user)
    current_user.videos.destroy_all
    list.each do |video|
      duration = ActiveSupport::Duration.parse(video['contentDetails']['duration'])
      identifier = video['identifier']
      published_on = Date.parse(video['snippet']['publishedAt'])
      title = video['snippet']['title']
      views = video['statistics']['viewCount'].to_i
      likes = video['statistics']['likeCount'].to_i
      comments = video['statistics']['commentCount'].to_i
      dislikes = video['statistics']['dislikes'].to_i
      rating = (((comments.to_f/views.to_f)+(likes.to_f/views.to_f))/2)-(dislikes.to_f/views.to_f)
      video = Video.new(identifier: identifier, duration: duration,
         published_on: published_on, title: title, views: views,
          comments: comments, dislikes: dislikes, rating: rating)
      video.user = current_user
      video.save
    end
  end
end
