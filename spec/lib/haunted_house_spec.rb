require 'haunted_house'

describe 'haunted house' do
  before(:all) do
    @house = HauntedHouse.new
  end

  it "Should be silly if we can't find the word" do
    vi, wi, message = @house.find_verb_word("SPRAY", "paint")
    vi.should == 20
    wi.should be_nil
    message.should eql("That's silly")
  end

  it "Should require two words" do
    vi, wi, message = @house.find_verb_word("SPRAY", "")
    wi.should be_nil
    message.should eql("I need two words")
  end

  it "If it doesn't find the verb and object" do
    vi, wi, message = @house.find_verb_word("FOO", "BAR")
    message.should eql("You don't make sense")
  end
end
