class ChannelsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_channel, only: %i[ show edit update destroy ]

  def index
    @channels = current_user.channels.where(album_id: params[:album_id])
  end

  def new
    @channel = Channel.new
  end

  def create
    @channel = current_user.channels.new(channel_params)
    @channel.album_id = params[:album_id]

    if @channel.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @channel.destroy

    respond_to do |format|
      format.turbo_stream
    end
  end

  def show
  end

  def edit
  end

  def update
    if @channel.update(channel_params)
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_channel
    @channel = Channel.find(params[:id])
  end

  def channel_params
    params.require(:channel).permit(:identifier, :keywords, :non_keywords, :published_before, :published_after,
                                    :minimum_duration, :maximum_duration, :no_of_videos)
  end
end
