require 'faraday'
require 'youtube_helper'

module Youtube
  module Channel
    def videos(videos, **args)
      url = url(args)
      video_ids = []
      response_object = fetch_data(url)
      video_ids << response_object['items'].map { |item| item.dig('id', 'videoId') }
      next_page_token = response_object['nextPageToken']
      # videos will always be a multiple of 50 in frontend
      video_ids << paginated_results({ next_page_token:, pages: (videos / 50) - 1, url: })
      { args[:channelId] => video_ids.flatten }
    end

    def url(args, params = { maxResults: 50, type: :video, part: :snippet}.merge(args))
      "https://www.googleapis.com/youtube/v3/search?#{params.map { |key, value| [key, value].join('=') }.join('&')}"
    end

    def paginated_results(args)
      url = add_next_token_to_url(args[:next_page_token], args[:url])
      video_ids = []
      args[:pages].times do
        response_object = fetch_data(url)
        video_ids << response_object['items'].map { |item| item.dig('id', 'videoId') }
        url = add_next_token_to_url(response_object['nextPageToken'], args[:url])
      end
      video_ids
    end

    def add_next_token_to_url(token, url)
      url + "&pageToken=#{token}"
    end

    def fetch_data(url)
      response = Faraday.get(url)
      JSON.parse(response.body)
    end

    module_function :url, :fetch_data, :paginated_results, :add_next_token_to_url, :videos
  end

  module Video
    def metadata(video_id, api_key)
      data = fetch_data('https://www.googleapis.com/youtube/v3/videos' ,{:part => [:snippet, :contentDetails, :statistics], id: video_id, key: api_key })['items'][0]
      
      data['snippet'].merge data['contentDetails'], data['statistics']
    end

    def dislikes(video_id)
      fetch_data('https://returnyoutubedislikeapi.com/votes', {videoId: video_id})['dislikes']
    end

    def fetch_data(url, params)
      connection = Faraday.new(
  url: ,request: { params_encoder: Faraday::FlatParamsEncoder },
  params: , headers: {'Content-Type' => 'application/json'}
) { |builder| builder.response :json }
      connection.get.body
    end

    module_function :metadata, :dislikes, :fetch_data
  end
end
