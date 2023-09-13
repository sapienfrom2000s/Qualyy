class VideosController < ApplicationController

  def index
    YoutubeapiCallToFetchChannelMetadataJob.perform_later current_user
  end
end
