require 'rails_helper'

RSpec.describe YoutubeapiCallToFetchChannelMetadataJob, type: :job do
  context "with a string seperated by semicolons" do
    it "checks whether apple and sky keywords are present in An apple floating in the sky" do
      keywords = 'apple;sky'.split(';')
      string = 'An apple in the sky'
      expect(subject.send(:keywords_in_string?, {keywords: keywords, string: string})).to be true
    end

    it "checks whether apple and sky keywords are present in An Apple floating in the Cloud" do
      keywords = 'apple;sky'.split(';')
      string = 'An Apple in the Cloud'
      expect(subject.send(:keywords_in_string?, {keywords: keywords, string: string})).to be false
    end

    it "checks whether official video and music keywords are present in Official Video | Some Artist | Music Video" do
      keywords = 'official video;music'.split(';')
      string = 'Official Video | Some Artist | Music Video'
      expect(subject.send(:keywords_in_string?, {keywords: keywords, string: string})).to be true
    end

    it "checks whether apple and sky keyword are absent in An apple floating in the sky" do
      keywords = 'apple;sky'.split(';')
      string = 'An apple in the sky'
      expect(subject.send(:keywords_not_in_string?, {keywords: keywords, string: string})).to be false
    end

    it "checks whether apple and sky keywords are absent in An Apple floating in the Cloud" do
      keywords = 'apple;sky'.split(';')
      string = 'An Apple in the Cloud'
      expect(subject.send(:keywords_not_in_string?, {keywords: keywords, string: string})).to be false
    end

    it "checks whether official video and music keywords are absent in Movie video | Some Actor | official" do
      keywords = 'official video;music'.split(';')
      string = 'Movie video | Some Actor | official'
      expect(subject.send(:keywords_not_in_string?, {keywords: keywords, string: string})).to be true
    end
  end
end
