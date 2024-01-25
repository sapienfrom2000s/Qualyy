# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  attr_reader :current_user

  BASE_URL = 'https://www.googleapis.com/youtube/v3/'

  def fetch(url)
    response = Faraday.get(url)
    JSON.parse(response.body)
  end
end
