require 'faraday'
require 'youtube_helper'

class Youtube 

  class Channel
    extend YoutubeHelper

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

    def self.url(args)
      url = 'https://www.googleapis.com/youtube/v3/search?maxResults=50&part=snippet&type=video'
      args.compact.each {|key,value| url += "&#{key}=#{value}"}
      url
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
  end

  class Video
    extend YoutubeHelper

    def self.metadata(video_id, api_key)
      data = {}
      ['statistics', 'contentDetails', 'snippet'].each do |part|
        data[part] = request("https://www.googleapis.com/youtube/v3/videos?part=#{part}&id=#{video_id}&key=#{api_key}")['items'][0][part]
      end
      {}.merge(data['statistics'], data['contentDetails'], data['snippet'])
    end 
  end
end
