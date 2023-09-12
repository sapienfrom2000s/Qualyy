require 'faraday'

class ChannelVideosJob
  include Sidekiq::Job

  # BASE_URL="https://www.googleapis.com/youtube/v3/"

  def perform(current_user_id, how_hard = "super hard", how_long = 1)
    sleep 10
    puts 'blabbering finishedddddd'
    puts "#{current_user_id}"
    video = Video.new(identifier: 'identifier')
    video.user_id = current_user_id
    puts video.save
  end

  # def perform(*args)
  #   # list = []
  #   # # channel video list contains title as well, so filtering it here will reduce api calls in videos
  #   # current_user.channels.each do |channel|
  #   #   list << youtube_channel_api(current_user, channel)
  #   #   list = keywords_filter(list, channel.filters)
  #   # end
  #   sleep 5
  #   system 'firefox'
  # end
end
