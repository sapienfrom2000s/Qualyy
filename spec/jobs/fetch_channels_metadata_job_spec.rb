require 'rails_helper'

RSpec.describe FetchChannelsMetadataJob, type: :job do

  let(:user){ create(:user) }

  xit 'enqueues job' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        FetchChannelsMetadataJob.perform_later(user)
      }.to have_enqueued_job
  end

  xit 'returns channels metadata in fixed format' do
      expect{ FetchChannelsMetadataJob.perform_later(user) }.to_change{ User.videos }.by(1)
  end
end

