require 'faraday'

class Fetch

  BASE_URL="https://www.googleapis.com/youtube/v3/"

  def self.channel_videos(url, videos, channelid)
    video_ids = []
    responseObject = request(url)
    video_ids << responseObject['items'].map{|item| item.dig('id', 'videoId')}
    nextPageToken = responseObject['nextPageToken']
    #videos will always be a multiple of 50 in frontend
    video_ids << paginated_results({nextPageToken: nextPageToken, pages: (videos/50)-1, url: url})
    { channelid => video_ids.flatten }
  end

  def self.video_metadata_batch(video_ids)
  end

  def self.video_dislikes_batch(video_ids)
  end

  def self.channel_metadata_url( **args )
    url = BASE_URL + 'search?maxResults=50&part=snippet&type=video'
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

  def self.request(url)
    response = Faraday.get(url)
    responseObject = JSON.parse(response.body)
  end
end
