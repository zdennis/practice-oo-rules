class WordListSanitizer
  def sanitize(words)
    [words].flatten.compact
  end
end


class WordList
  attr_reader :words
  
  def initialize
    @sanitizer = WordListSanitizer.new
  end
  
  def words=(words)
    words = @sanitizer.sanitize(words)
    @words = words.map{ |str| 
      str = str.gsub(/[^\w\s\!\"]/, '')
      str = str.gsub(/\s+/, ' ').strip
      str = str.split(/\s/).map { |nstr|
        nstr =~ /^[aeiou]/ ? nstr.reverse : nstr
      }.join(" ")
    }
  end
end