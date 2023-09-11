class VideosController < ApplicationController
  before_action :authenticate_user!

  def index
    current_user.videos.destroy_all
    
      flash[:notice] = "Your request fetches #{current_user.videos.count} videos.\nMake a stronger filter and bring it down to less than 100"
      redirect_to channels_path, notice: 'Insufficient rights!'
    end
    Video.calculate_metrics(current_user)
  end
end

# Video.filter(current_user)
 #   if current_user.videos.count > 100