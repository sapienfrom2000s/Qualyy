class VideosController < ApplicationController
  before_action :authenticate_user!

  def index
    @videos = current_user.videos
  end

  def new
    YoutubeapiCallToFetchChannelMetadataJob.perform_later current_user
  end
end
