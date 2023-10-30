class ChannelsController < ApplicationController
  before_action :authenticate_user!

  def index
    @channels = current_user.channels
  end

  def new
    @channel = Channel.new
  end

  def create
    @channel = current_user.channels.new(channel_params)

    if @channel.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @channel = Channel.find(params[:id])
    @channel.destroy

    respond_to do |format|
      format.turbo_stream
    end
  end

  def show
    @channel = Channel.find(params[:id])
  end

  def edit
    @channel = Channel.find(params[:id])
  end

  def update
    @channel = Channel.find(params[:id])

    if @channel.update(channel_params)
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def channel_params
    params.require(:channel).permit(:identifier, :keywords, :non_keywords, :published_before, :published_after,
                                    :minimum_duration, :maximum_duration, :no_of_videos)
  end
end
