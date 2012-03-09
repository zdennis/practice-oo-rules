# things aren't shareable yet
# real object composition would let this work if we wanted to create other
# classes with similar rules

class WordListSanitizer
  def initialize(words)
    @words = words
  end
  
  def convert_to_array
    @words = [@words].flatten.compact
    self
  end
  
  def strip_unallowed_characters
    @words = @words.map{ |str| str.gsub(/[^\w\s\!\"]/, '') }
    self
  end
  
  def remove_unnecessary_whitespace
    @words = @words.map{ |str| str.gsub(/\s+/, ' ').strip }
    self
  end
  
  def reverse_words_that_start_with_a_vowel
    @words = @words.map{ |str|
      str = str.split(/\s/).map { |nstr|
        nstr =~ /^[aeiou]/ ? nstr.reverse : nstr
      }.join(" ")
    }
    self
  end
  
  def and_return_words
    @words
  end
end


class WordList
  attr_reader :words
  
  def initialize(sanitizer=WordListSanitizer)
    @sanitizer = sanitizer
  end
  
  def words=(words)
    @words = @sanitizer.new(words).
      convert_to_array.
      strip_unallowed_characters.
      remove_unnecessary_whitespace.
      reverse_words_that_start_with_a_vowel.
      and_return_words
  end
end