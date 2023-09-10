class VideosController < ApplicationController

  def index
    current_user.videos.destroy_all
    Video.filter(current_user)
    if current_user.videos.count > 100
      flash[:notice] = "Your request fetches #{current_user.videos.count} videos.Make a stronger filter and bring it down to less than 100"
      redirect_to channels_path
    end
    Video.calculate_metrics(current_user)
  end
end
