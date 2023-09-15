class FetchvideometadataJob < ApplicationJob
  queue_as :default

  attr_reader :list

  after_perform do
    FetchVideoDislikesJob.perform_later(list, current_user)
  end

  def perform(video_list, current_user)
    @current_user = current_user
    @list = []
    video_list.each do |video|
      urls = form_urls(video['id']['videoId'], current_user.youtube_api_key)
      begin
        video_metadata = fetch(urls)
      rescue => exception
        puts exception # display error in broadcast
        next          
      end
      video_metadata['id'] = video['id']['videoId']
      list << video_metadata if metadata_satisfies_duration_filter?(video_metadata, 
        { minimum_duration: video['minimum_duration'],
        maximum_duration: video['maximum_duration'] })
    end
  end

  private

  def fetch(urls)
    video_metadata = {}
    urls.each do |key, url|
      video_metadata[key] = super(url)['items'][0][key]
    end
    video_metadata
  end

  def form_urls(videoId, api_key)
    {
      'statistics' => BASE_URL + 'videos?' + '&part=statistics' + "&id=#{videoId}" + "&key=#{api_key}",
      'contentDetails' => BASE_URL + 'videos?' + '&part=contentDetails' + "&id=#{videoId}" + "&key=#{api_key}",
      'snippet' => BASE_URL + 'videos?' + '&part=snippet' + "&id=#{videoId}" + "&key=#{api_key}"
    }
  end

  def metadata_satisfies_duration_filter?(metadata, args)
    duration = ActiveSupport::Duration.parse(metadata['contentDetails']['duration']).to_s.to_i
    duration >= args[:minimum_duration] && duration <= args[:maximum_duration]
  end
end
