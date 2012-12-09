require 'haunted_house'

describe 'hafunted house' do
  before(:all) do
    @house = HauntedHouse.new
  end

  it "Should be silly if we can't find the word" do
    vi, wi, message = @house.find_verb_word("SPRAY", "paint")
    vi.should == 20
    wi.should be_nil
    message.should eql("That's silly")
  end
end
