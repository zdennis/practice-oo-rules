require 'spec_helper'

describe WordList do
  let(:word_list_sanitizer){ stub("word list sanitizer") }
  
  before do
    WordListSanitizer.stub(:new).and_return word_list_sanitizer
  end
  
  describe "#words=" do
    let(:words){ ["the words", "go here"] }
    let(:sanitized_words){ ["sanitized words"] }

    before do
      word_list_sanitizer.stub!(:sanitize).and_return sanitized_words
    end
    
    it "sanitizes the words" do
      word_list_sanitizer.should_receive(:sanitize).with(words).and_return sanitized_words
      subject.words = words
    end
    
    it "sets stores the sanitized words" do
      subject.words = words
      subject.words.should eq(sanitized_words)
    end
  end
end
