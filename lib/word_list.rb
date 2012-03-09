class WordListSanitizer
  def sanitize(words)
    @words = words
    convert_to_array
    strip_unallowed_characters
    remove_unnecessary_whitespace
  end
  
  protected
  
  def convert_to_array
    @words = [@words].flatten.compact
  end
  
  def strip_unallowed_characters
    @words = @words.map{ |str| str.gsub(/[^\w\s\!\"]/, '') }
  end
  
  def remove_unnecessary_whitespace
    @words = @words.map{ |str| str.gsub(/\s+/, ' ').strip }
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
      str = str.split(/\s/).map { |nstr|
        nstr =~ /^[aeiou]/ ? nstr.reverse : nstr
      }.join(" ")
    }
  end
end