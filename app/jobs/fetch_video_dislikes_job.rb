class FetchVideoDislikesJob < ApplicationJob
  queue_as :default

  attr_reader :list

  after_perform do
    PushMetadataToDatabaseJob.perform_later(list, current_user)
  end

  def perform(list, current_user)
    @current_user = current_user
    @list = list.first(100).map do |metadata|
      url = form_url(metadata['id'])
      begin
        dislike_object = fetch(url)
      rescue => exception
        puts exception # broadcast it 
        next
      end
      add_dislikes_to_hash(metadata['statistics'], dislike_object['dislikes'])
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
