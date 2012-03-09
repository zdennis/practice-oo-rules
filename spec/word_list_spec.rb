require 'spec_helper'

describe WordList do
  describe "#words=" do
    it "handles nil as an empty array" do
      subject.words = nil
      subject.words.should eq([])
    end
    
    it "handles a string as a single-word array" do
      subject.words = "hello there"
      subject.words.should eq(["hello there"])
    end
    
    it "reduces consecutive spaces to a single space" do
      subject.words = ["hello        world!"]
      subject.words.should eq(["hello world!"])
    end
    
    it "strips leading white-space" do
      subject.words = [" \tHowdy"]
      subject.words.should eq(["Howdy"])
    end
    
    it "strips trailing white-space" do
      subject.words = ["Au revoir\t "]
      subject.words.should eq(["Au revoir"])
    end

    it "reverses any word that starts with a vowel" do
      subject.words = ["apples", "berries", "apricots and oranges please"]
      subject.words.should eq(["selppa", "berries", "stocirpa dna segnaro please"])
    end
  end
end
