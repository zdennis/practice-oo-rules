class WordList
  attr_reader :words
  
  def words=(words)
    @words = 
      reverse_words_that_start_with_a_vowel(
        remove_unnecessary_whitespace(
          strip_unallowed_characters(
            convert_to_array(
              words))))
  end
  
  protected
  
  def convert_to_array(words)
    [words].flatten.compact
  end
  
  def strip_unallowed_characters(words)
    words.map{ |str| str.gsub(/[^\w\s\!\"]/, '') }
  end
  
  def remove_unnecessary_whitespace(words)
    words.map{ |str| str.gsub(/\s+/, ' ').strip }
  end
  
  def reverse_words_that_start_with_a_vowel(words)
    words.map{ |str|
      str = str.split(/\s/).map { |nstr|
        nstr =~ /^[aeiou]/ ? nstr.reverse : nstr
      }.join(" ")
    }
  end  
end