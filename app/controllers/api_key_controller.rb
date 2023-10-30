class ApiKeyController < ApplicationController
  before_action :authenticate_user!

  def show
    @api_key = current_user.youtube_api_key
  end

  def edit
    @api_key = current_user.youtube_api_key
  end

  def update
    if current_user.update(api_key_params)
      flash[:notice] = 'API Key successfully updated'
      redirect_to api_key_path
    else
      @api_key = current_user.youtube_api_key
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def api_key_params
    params.require(:api_key).permit(:youtube_api_key)
  end
end
