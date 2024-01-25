# frozen_string_literal: true

class VideosController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_album = current_user.albums.find(params[:album_id])
    @videos = @current_album.videos.order(rating: :desc)
  end

  def new
    @current_album = current_user.albums.find(params[:album_id])
    YoutubeapiCallToFetchChannelMetadataJob.perform_later current_user, @current_album
  end
end
