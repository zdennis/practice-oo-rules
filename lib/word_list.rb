class WordList
  attr_reader :words
  
  def words=(words)
    words = [words].flatten
    @words = words.map{ |str| 
      str = str.gsub(/\s+/, ' ').strip
      str.split(/\s/).map { |nstr|
        nstr =~ /^[aeiou]/ ? nstr.reverse : nstr
      }.join(" ")
    }
  end
end