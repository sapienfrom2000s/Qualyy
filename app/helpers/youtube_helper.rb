module YoutubeHelper
  def request(url)
    response = Faraday.get(url)
    responseObject = JSON.parse(response.body)
  end
end
