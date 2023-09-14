class FetchVideoDislikesJob < ApplicationJob
  queue_as :default

  attr_reader :list

  after_perform do
    PushMetadataToDatabaseJob.perform_later(list)
  end

  def perform(list)
    @list = list.first(100).map do |metadata|
      url = form_url(metadata['items'][0]['snippet']['id'])
      begin
        dislike_object = fetch(url)
      rescue => exception
        puts exception # broadcast it 
        next
      end
      add_dislikes_to_metadata(metadata['items'][0]['statistics'], dislike_object['dislikes'])
      metadata
    end.reject {|item| item.nil?}
  end

  private

  def form_url(videoId)
    "https://returnyoutubedislikeapi.com/votes?videoId=#{videoId}"
  end

  def add_dislikes_to_hash(hash, dislikes)
    hash['dislikes'] = dislikes
  end
end
