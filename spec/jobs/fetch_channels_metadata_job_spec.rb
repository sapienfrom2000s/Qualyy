require 'rails_helper'

RSpec.describe FetchChannelsMetadataJob, type: :job do

  let(:user){ create(:user) }

  it 'enqueues job' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        FetchChannelsMetadataJob.perform_later(user)
      }.to have_enqueued_job
  end

  it 'saves videos to database' do
      fetchchannelmetadata = class_double(FetchChannelsMetadataJob)

      allow(Filter).to receive(:channel_videos).with(:channel_id, :filters).and_return(%w[videoid1, videoid2, videoid3, videoid4])
      allow(Filter).to receive(:video_ids).with(:videoids, :filters).and_return([{ :identifier => 'videoid1', :duration => 23, :published_on => Date.new(2023, 9, 30), :title => 'title1', :views => 400, :comments => 200, :likes => 100 }])
      allow(Fetch).to receive(:dislikes).with(:videosids).and_return([{:identifier => 'wallah',dislikes: 23}])
      ActiveJob::Base.queue_adapter = :test
      expect{ FetchChannelsMetadataJob.perform_later(user) }.to_change{ User.videos }.by(1)
  end
end

