class VideosController < ApplicationController

  before_action :authenticate_user!

  def index
    @videos = current_user.videos.order(rating: :desc)
  end

  def new
    YoutubeapiCallToFetchChannelMetadataJob.perform_later current_user
  end
end
