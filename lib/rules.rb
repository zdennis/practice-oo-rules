class ConvertToArraySanitizer
  def sanitize(words)
    [words].flatten.compact
  end
end

class StripUnallowedCharactersSanitizer
  def sanitize(words)
    words.map{ |str| str.gsub(/[^\w\s\!\"]/, '') }
  end
end

class RemoveUnnecessaryWhitespaceSanitizer
  def sanitize(words)
    words.map{ |str| str.gsub(/\s+/, ' ').strip }
  end
end

class ReverseWordsThatStartWithVowel
  def sanitize(words)
    words.map{ |str|
      str = str.split(/\s/).map { |nstr|
        nstr =~ /^[aeiou]/ ? nstr.reverse : nstr
      }.join(" ")
    }
  end
end

