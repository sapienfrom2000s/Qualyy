class ChannelsController < ApplicationController
  def index
    @channels = current_user.channels
  end

  def new
    @channel = Channel.new
  end

  def create
    @filter = Filter.new(filter_params)
    @channel = Channel.new(channel_params)

    @channel.filter = @filter
    @channel.user = current_user

    if @channel.save
      respond_to do |format|
        format.html { redirect_to @channel, notice: "Quote was successfully created." }
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
      format.html { redirect_to channels_path, status: :see_other }
      format.turbo_stream
    end
  end

  def show
    @channel = Channel.find(params[:id])
  end

  private
  
  def filter_params
    params.require(:channel).permit(:keywords, :non_keywords, :minimum_duration, :maximum_duration, :videos, :published_after, :published_before)
  end

  def channel_params
    params.require(:channel).permit(:identifier)
  end
end
