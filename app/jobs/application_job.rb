class ApplicationJob < ActiveJob::Base

  BASE_URL="https://www.googleapis.com/youtube/v3/"

  def fetch(url)
    response = Faraday.get(url)
    responseObject = JSON.parse(response.body)
  end

end
