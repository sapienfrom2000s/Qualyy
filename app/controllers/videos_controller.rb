class VideosController < ApplicationController

  before_action :authenticate_user!

  def index
    @videos = Channel.find_by_sql("SELECT videos.* FROM channels INNER JOIN videos ON channels.id = videos.channel_id WHERE channels.user_id = #{current_user.id}")
  end

  def new
    YoutubeapiCallToFetchChannelMetadataJob.perform_later current_user
  end
end
