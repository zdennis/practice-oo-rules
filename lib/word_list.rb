class WordList
  attr_reader :words
  
  def words=(words)
    @words = words.map{ |str| str.gsub(/\s+/, ' ').lstrip }
  end
end