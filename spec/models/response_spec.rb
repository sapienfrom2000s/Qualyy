require "rails_helper"

RSpec.describe Response, type: :model do
  context "with a string seperated by semicolons" do
    it "checks whether apple and sky keywords are present in An apple floating in the sky" do
      keywords = 'apple;sky'.split(';')
      string = 'An apple in the sky'
      expect(Response.keywords_in_string?({keywords: keywords, string: string})).to be true
    end

    it "checks whether Apple and sky keywords are present in An Apple floating in the Cloud" do
      keywords = 'apple;sky'.split(';')
      string = 'An Apple in the Cloud'
      expect(Response.keywords_in_string?({keywords: keywords, string: string})).to be false
    end

    it "checks whether official video and music keywords are present in Official Video | Some Artist | Music Video" do
      keywords = 'official video;music'.split(';')
      string = 'Official Video | Some Artist | Music Video'
      expect(Response.keywords_in_string?({keywords: keywords, string: string})).to be true
    end
  end
end