require 'faraday'

class YoutubeapiCallToFetchChannelMetadataJob < ApplicationJob
  queue_as :default

  attr_reader :list

  after_perform do
    FetchvideometadataJob.perform_later(list.flatten, current_user)
  end

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
      add_duration_filter_as_property(video_list,
         channel.filter.minimum_duration, channel.filter.maximum_duration)
      list << video_list
    end
  end

  private

  def add_duration_filter_as_property(video_list, minimum_duration, maximum_duration)
    video_list.each do |video|
      video['minimum_duration'] = minimum_duration
      video['maximum_duration'] = maximum_duration
    end
  end

  def fetch_channel_videos(channel)
    video_list = []
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
    url += "&maxResults=5"
    url += "&part=snippet"
    url += "&publishedAfter=#{channel.filter.published_after.rfc3339}" if channel.filter.published_after
    url += "&publishedBefore=#{channel.filter.published_before.rfc3339}" if channel.filter.published_before
    url
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
    video_list.filter do |item|
      string = item['snippet']['title']
      keywords = filter.keywords.split(';')
      non_keywords = filter.non_keywords.split(';')
      keywords_in_string?({string: string, keywords: keywords}) &&\
       keywords_not_in_string?({string: string, keywords: non_keywords})
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
