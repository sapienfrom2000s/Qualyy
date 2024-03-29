# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'StringUtils' do
  describe '#keywords_present?' do
    it 'is positive that keywords are present' do
      keywords = 'apple;sky'.split(';')
      string = StringUtils.new 'An apple in the sky'
      expect(string.keywords_present?(keywords)).to be true
    end

    it 'is positive that keywords are not present' do
      keywords = 'apple;sky'.split(';')
      string = StringUtils.new 'An Apple in the Cloud'
      expect(string.keywords_present?(keywords)).to be false
    end

    it 'is positive that keywords are present' do
      keywords = 'official video;music'.split(';')
      string = StringUtils.new 'Official Video | Some Artist | Music Video'
      expect(string.keywords_present?(keywords)).to be true
    end
  end

  describe '#keywords_absent?' do
    it 'is positive that keywords are not absent' do
      keywords = 'apple;sky'.split(';')
      string = StringUtils.new 'An apple in the sky'
      expect(string.keywords_absent?(keywords)).to be false
    end

    it 'is positive that keywords are not absent' do
      keywords = 'apple;sky'.split(';')
      string = StringUtils.new 'An Apple in the Cloud'
      expect(string.keywords_absent?(keywords)).to be false
    end

    it 'is positive that keywords are absent' do
      keywords = 'official video;music'.split(';')
      string = StringUtils.new 'Movie video | Some Actor | official'
      expect(string.keywords_absent?(keywords)).to be true
    end
  end
end
