require 'haunted_house'

describe 'haunted house' do
  before(:all) do
    @flags = []
    @flags[18] = @flags[17] = @flags[2] = @flags[26] = @flags[28] = @flags[23] = true
    @carrying = []
    @house = HauntedHouse.new(@flags, @carrying)
  end

  it "Should be silly if we can't find the word" do
    vi, wi, message = @house.message("SPRAY", "paint")
    vi.should == 20
    wi.should be_nil
    message.should eql("That's silly")
  end

  it "Should require two words" do
    vi, wi, message = @house.message("SPRAY", "")
    wi.should be_nil
    message.should eql("I need two words")
  end

  it "If it doesn't find the verb and object" do
    vi, wi, message = @house.message("FOO", "BAR")
    message.should eql("You don't make sense")
  end

  it "Check whether you are carrying" do
    vi, wi, message = @house.message("USE", "Matches")
    message.should eql("You don't have Matches")
  end

  it "Check going a direction" do
    vi, wi, message = @house.message("GO", "North")
    message.should be_nil
    vi.should == 2
    wi.should == 18
  end

  it "Check carrying" do
    result = @house.create_carrying([false, true], ["Steam", "Shovel"])
    result.should eql(["Shovel"])
  end
end
