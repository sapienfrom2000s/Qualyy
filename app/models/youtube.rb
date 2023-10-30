require 'faraday'
require 'youtube_helper'

class Youtube 

  class Channel

    def self.videos(videos, **args)
      url = url(args)
      video_ids = []
      responseObject = request(url)
      video_ids << responseObject['items'].map{|item| item.dig('id', 'videoId')}
      nextPageToken = responseObject['nextPageToken']
      #videos will always be a multiple of 50 in frontend
      video_ids << paginated_results({nextPageToken: nextPageToken, pages: (videos/50)-1, url: url})
      { args[:channelId] => video_ids.flatten }
    end

    def self.url(args, params = { maxResults: 50, type: :video, part: :snippet }.merge(args))
      'https://www.googleapis.com/youtube/v3/search?' +
       params.map{|key, value| [key, value].join('=')}.join('&')
    end

    private

    def self.paginated_results(args)
      url = addNextTokenToURL(args[:nextPageToken], args[:url])
      video_ids = []
      args[:pages].times do
        responseObject = request(url)
        video_ids << responseObject['items'].map{|item| item.dig('id', 'videoId')}
        url = addNextTokenToURL(responseObject['nextPageToken'], args[:url])
      end
      video_ids
    end

    def self.addNextTokenToURL(token, url)
      url + "&pageToken=#{token}"
    end

    def self.request(url)
     response = Faraday.get(url)
     responseObject = JSON.parse(response.body)
    end
  end

  class Video

    def self.metadata(video_id, api_key)
      data = {}
      ['statistics', 'contentDetails', 'snippet'].each do |part|
        data[part] = request("https://www.googleapis.com/youtube/v3/videos?part=#{part}&id=#{video_id}&key=#{api_key}")['items'][0][part]
      end
      {}.merge(data['statistics'], data['contentDetails'], data['snippet'])
    end 

    def self.dislikes(video_id)
      request("https://returnyoutubedislikeapi.com/votes?videoId=#{video_id}")['dislikes']
    end

    def self.request(url)
    response = Faraday.get(url)
    responseObject = JSON.parse(response.body)
   end
  end
end
