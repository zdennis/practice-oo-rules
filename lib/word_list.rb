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

module DI
  def self.mappings
    @mappings ||= {}
  end
  
  
  module ConstructorMethods
    def constructor(*args)
      @constructor_args = args
      define_method :initialize do
        args.each do |key|
          instance_variable_set "@#{key}", DI.mappings[self.class.name.to_sym][key]
        end
      end
    end
  end

  def self.construct(key, opts={})
    DI.mappings[key] = opts[:with]
  end
  
  construct :WordList, :with => {
    :sanitizers => [
      ConvertToArraySanitizer.new,
      StripUnallowedCharactersSanitizer.new,
      RemoveUnnecessaryWhitespaceSanitizer.new,
      ReverseWordsThatStartWithVowel.new ]}
end

Class.send :include, DI::ConstructorMethods

class WordList
  attr_reader :words
    
  constructor :sanitizers
    
  def words=(words)
    @words = @sanitizers.inject(words) do |words, sanitizer|
      sanitizer.sanitize words
    end
  end
end