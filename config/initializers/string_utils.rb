# frozen_string_literal: true

class StringUtils
  attr_accessor :string

  def initialize(string)
    @string = string.to_str
  end

  def keywords_present?(keywords)
    keywords.all? do |keyword|
      keyword = keyword.downcase
      !string.downcase.scan(/#{keyword}/).empty?
    end
  end

  def keywords_absent?(keywords)
    keywords.all? do |keyword|
      keyword = keyword.downcase
      string.downcase.scan(/#{keyword}/).empty?
    end
  end
end
