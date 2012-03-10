require 'di'
require 'rules'

class WordList
  attr_reader :words
    
  constructor :sanitizers
    
  def words=(words)
    @words = @sanitizers.inject(words) do |words, sanitizer|
      sanitizer.sanitize words
    end
  end
end