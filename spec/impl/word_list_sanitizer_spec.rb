require 'spec_helper'

describe WordListSanitizer do
  describe "#sanitize(words)" do
    it "handles nil as an empty array" do
      words = subject.sanitize(nil)
      words.should eq([])
    end
    
    it "handles a string as a single-word array" do
      words = subject.sanitize("hello there")
      words.should eq(["hello there"])
    end
    
    it "reduces consecutive spaces to a single space" do
      words = subject.sanitize(["hello        world!"])
      words.should eq(["hello world!"])
    end
    
    it "strips leading white-space" do
      words = subject.sanitize([" \tHowdy"])
      words.should eq(["Howdy"])
    end
    
    it "strips trailing white-space" do
      words = subject.sanitize(["Au revoir\t "])
      words.should eq(["Au revoir"])
    end

    it "reverses any word that starts with a vowel" do
      words = subject.sanitize(["apples", "berries", "apricots and oranges please"])
      words.should eq(["selppa", "berries", "stocirpa dna segnaro please"])
    end
    
    it "strips non alpha-numeric characters except: _ \" !" do
      "` ~ @ # $ % ^ & * ( ) - + = [ ] \ { } | ; ' : , . / < > ?".split(" ").each do |ch|
        words = subject.sanitize(["this #{ch}", "certainly", "#{ch} does"])
        words.should eq(["this", "certainly", "does"])
      end
    end
  end
end
