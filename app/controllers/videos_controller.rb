class VideosController < ApplicationController

  before_action :authenticate_user!

  def index
    YoutubeapiCallToFetchChannelMetadataJob.perform_later current_user
  end
end
