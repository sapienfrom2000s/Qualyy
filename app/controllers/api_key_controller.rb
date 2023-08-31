class ApiKeyController < ApplicationController
  before_action :authenticate_user!

  def show
    @api_key = current_user.youtube_api_key
  end

  def edit
  end

  def update
  end
end
