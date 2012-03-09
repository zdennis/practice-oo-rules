require 'spec_helper'

describe WordList do
  describe "#words=" do
    it "reduces consecutive spaces to a single space" do
      subject.words = ["hello        world!"]
      subject.words.should eq(["hello world!"])
    end
  end
end

# a