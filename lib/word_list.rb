

module ConvertToArraySanitizer
  def self.sanitize(words)
    [words].flatten.compact
  end
end

module StripUnallowedCharactersSanitizer
  def self.sanitize(words)
    words.map{ |str| str.gsub(/[^\w\s\!\"]/, '') }
  end
end

module RemoveUnnecessaryWhitespaceSanitizer
  def self.sanitize(words)
    words.map{ |str| str.gsub(/\s+/, ' ').strip }
  end
end

module ReverseWordsThatStartWithVowel
  def self.sanitize(words)
    words.map{ |str|
      str = str.split(/\s/).map { |nstr|
        nstr =~ /^[aeiou]/ ? nstr.reverse : nstr
      }.join(" ")
    }
  end
end

class WordList
  attr_reader :words
  
  SANITIZERS = [
    ConvertToArraySanitizer,
    StripUnallowedCharactersSanitizer,
    RemoveUnnecessaryWhitespaceSanitizer,
    ReverseWordsThatStartWithVowel]
  
  def words=(words)
    @words = SANITIZERS.inject(words) do |words, sanitizer|
      sanitizer.sanitize words
    end
  end
end