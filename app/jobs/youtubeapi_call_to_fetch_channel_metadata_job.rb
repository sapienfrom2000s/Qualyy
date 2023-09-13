require 'faraday'

class YoutubeapiCallToFetchChannelMetadataJob < ApplicationJob
  queue_as :default

  attr_reader :list, :current_user

  BASE_URL="https://www.googleapis.com/youtube/v3/"

  def perform(current_user)
    @current_user = current_user
    @list = []
    current_user.channels.each do |channel|
      begin
        video_list = fetch_channel_videos(channel)
      rescue => exception
        puts exception #broadcast exception with red
        next
      end
      video_list = keywords_filter(video_list, channel.filter)
      list << video_list
    end
  end

  private

  def fetch_channel_videos(channel)
    video_list = []
    binding.pry
    url = formurl(channel)
    responseObject = fetch(url)
    video_list << responseObject['items']
    nextPageToken = responseObject['nextPageToken']
    video_list << paginated_results({nextPageToken: nextPageToken, pages: (channel.filter.videos/50)-1, url: url})
    video_list.flatten
  end

  def formurl(channel)
    url = BASE_URL + 'search?' + "key=#{current_user.youtube_api_key}"
    url += "&channelId=#{channel.identifier}"
    url += "&maxResults=50"
    url += "&part=snippet"
    url += "&publishedAfter=#{channel.filter.published_after.rfc3339}" if channel.filter.published_after
    url += "&publishedBefore=#{channel.filter.published_before.rfc3339}" if channel.filter.published_before
    url
  end

  def fetch(url)
    response = Faraday.get(url)
    responseObject = JSON.parse(response.body)
  end

  def paginated_results(args)
    url = addNextTokenToURL(args[:nextPageToken], args[:url])
    video_list = []
    args[:pages].times do
      responseObject = fetch(url)
      video_list << responseObject['items']
      url = addNextTokenToURL(responseObject['nextPageToken'], args[:url])
    end
    video_list
  end

  def addNextTokenToURL(token, url)
    url + "&pageToken=#{token}"
  end

  def keywords_filter(video_list, filter)
    video_list.select do |item|
      string = item['snippet']['title']
      keywords = filter.keywords.split(';')
      non_keywords = filter.non_keywords.split(';')
      keywords_in_string?({string: string, keywords: keywords}) unless keywords.empty? &&\
       keywords_not_in_string?({string: string, keywords: non_keywords}) unless keywords.empty?
    end
  end

  def keywords_in_string?(args)
    args[:keywords].all? do |keyword|
      keyword = keyword.downcase
      !(args[:string].downcase.scan(/#{keyword}/).empty?)
    end
  end

  def keywords_not_in_string?(args)
    args[:keywords].all? do |keyword|
      keyword = keyword.downcase
      args[:string].downcase.scan(/#{keyword}/).empty?
    end
  end
end
