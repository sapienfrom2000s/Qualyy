require 'faraday'

class Video < ApplicationRecord
  belongs_to :user

  BASE_URL="https://www.googleapis.com/youtube/v3/"
  
  def self.filter(current_user)
    list = []
    # channel video list contains title as well, so filtering it here will reduce api calls in videos
    current_user.channels.each do |channel|
      list << youtube_channel_api(current_user, channel)
      list = keywords_filter(list, channel.filters)
      list.each do |item|
        video_metadata = youtube_video_metadata(item['id']['videoId'], current_user.youtube_api_key)
        push_to_db(current_user, video_metadata) if metadata_satisfies?(video_metadata, {minimum_duration: channel.filter.minimum_duration,
           maximum_duration: channel.filter.maximum_duration})
      end
    end
  end

  def self.calculate_metrics(current_user)
  end

  private

  def push_to_db(current_user, metadata)
    duration = ActiveSupport::Duration.parse(metadata['items'][0]['contentDetails']['duration'])
    identifier = metadata['items'][0]['id']
    published_on = Date.parse(metadata["items"][0]["snippet"]["publishedAt"])
    title = metadata["items"][0]["snippet"]["title"]
    views = metadata["items"][0]["statistics"]["viewCount"]
    comments = metadata["items"][0]["statistics"]["commentCount"]
    video = Video.new(identifier: identifier, duration: duration, published_on: published_on, title: title, views: views, comments: comments)
    video.user = current_user
    video.save
  end

  def self.metadata_satisfies?(metadata, args)
    duration = ActiveSupport::Duration.parse(metadata['items'][0]['contentDetails']['duration']).to_s.to_i
    duration >= args[:minimum_duration] && duration <= args[:maximum_duration]
  end

  def self.youtube_video_metadata(videoId, api_key)
    url = BASE_URL + '/videos?' + 'part=contentDetails&part=statistics&part=snippet' + "&id=#{videoId}" + "&key=#{api_key}"
    fetch(url)
  end

  def self.filter_wrt_video_metadata

  end

  def self.keywords_filter(list, filter)
    list.flatten!.select do |item|
      string = item['snippet']['title']
      keywords = filter.keywords.split(';')
      non_keywords = filter.non_keywords.split(';')
      keywords_in_string?({string: string, keywords: keyword}) &&\
       keywords_not_in_string?({string: string, keywords: non_keyword})
    end
  end

  def self.youtube_channel_api(current_user, channel)
    list = []
    url = formurl(current_user, channel)
    responseObject = fetch(url)
    list << responseObject['items']
    nextPageToken = responseObject['nextPageToken']
    list << paginated_results({nextPageToken: nextPageToken, pages: (channel.filter.videos/50)-1, url: url})
  end
  
  def self.fetch(url)
    response = Faraday.get(ERB::Util.url_encode(url))
    responseObject = JSON.parse(response.body)
  end
  
  def self.paginated_results(args)
    url = addNextTokenToURL(args[:nextPageToken], args[:url])
    list = []
    args[:pages].times do
      responseObject = fetch(args[:url])
      list << responseObject['items']
      url = addNextTokenToURL(responseObject['nextPageToken'])
    end
    list
  end
  
  def self.addNextTokenToURL(token, url)
    url + "&pageToken=#{token}"
  end

  def self.formurl(current_user, channel)
    url = BASE_URL + 'search?' + "key=#{current_user.youtube_api_key}"
    url += "&channelId=#{channel.identifier}"
    url += "&maxResults=50"
    url += "&part=snippet"
    url += "&publishedAfter=#{channel.filter.published_after.rfc3339}" if channel.published_after
    url += "&publishedBefore=#{channel.filter.published_before.rfc3339}" if channel.published_before
  end

  def self.keywords_in_string?(args)
    args[:keywords].all? do |keyword|
      keyword = keyword.downcase
      !(args[:string].downcase.scan(/#{keyword}/).empty?)
    end
  end

  def self.keywords_not_in_string?(args)
    args[:keywords].all? do |keyword|
      keyword = keyword.downcase
      args[:string].downcase.scan(/#{keyword}/).empty?
    end
  end
end
