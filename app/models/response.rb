class Response
  def self.keywords_in_string?(args)
    args[:keywords].all? do |keyword|
      keyword = keyword.downcase
      !(args[:string].downcase.scan(/#{keyword}/).empty?)
    end
  end

  def self.keywords_not_in_string?(args)
    args[:keywords].all? do |keyword|
      keyword = keyword.downcase
      args[:string].downcase.scan(/#{keyword}/).empty?
    end
  end
end