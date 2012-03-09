module Rules
  module ConvertToArray
    def words=(words)
      [words].flatten.compact
    end
  end
end

class WordList
  attr_reader :words
  
  include Rules::ConvertToArray
  
  def words=(words)
    words = super(words)
    @words = words.map{ |str| 
      str = str.gsub(/[^\w\s\!\"]/, '')
      str = str.gsub(/\s+/, ' ').strip
      str = str.split(/\s/).map { |nstr|
        nstr =~ /^[aeiou]/ ? nstr.reverse : nstr
      }.join(" ")
    }
  end
end