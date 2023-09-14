class FetchvideometadataJob < ApplicationJob
  queue_as :default

  attr_reader :list

  after_perform do
    FetchVideoDislikesJob.perform_later(current_user, list)
  end

  def perform(current_user, channel_list)
    @list = []
    channel_list.each do |channel, video_list|
      video_list.each do |video|
        url = formurl(video['id']['videoId'], current_user.youtube_api_key)
        begin
          video_metadata = fetch(url)          
        rescue => exception
          puts exception # display error in broadcast
          next          
        end
        list << video_metadata if metadata_satisfies_duration_filter?(video_metadata, 
          { minimum_duration: channel.filter.minimum_duration,
          maximum_duration: channel.filter.maximum_duration })
      end
    end
  end

  private

  def formurl(videoId, api_key)
    url = BASE_URL + '/videos?' + 'part=contentDetails&part=statistics&part=snippet' + "&id=#{videoId}" + "&key=#{api_key}"
  end

  def metadata_satisfies_duration_filter?(metadata, args)
    duration = ActiveSupport::Duration.parse(metadata['items'][0]['contentDetails']['duration']).to_s.to_i
    duration >= args[:minimum_duration] && duration <= args[:maximum_duration]
  end
end
