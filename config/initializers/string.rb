class String
  def keywords_present?(keywords)
    keywords.all? do |keyword|
      keyword = keyword.downcase
      !(self.downcase.scan(/#{keyword}/).empty?)
    end
  end

  def keywords_absent?(keywords)
    keywords.all? do |keyword|
      keyword = keyword.downcase
      self.downcase.scan(/#{keyword}/).empty?
    end
  end
end

