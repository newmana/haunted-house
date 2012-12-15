require 'haunted_house'

describe 'haunted house' do
  before(:all) do
    @flags = []
    @flags[18] = @flags[17] = @flags[2] = @flags[26] = @flags[28] = @flags[23] = true
    @carrying = []
    @house = HauntedHouse.new(57, @flags, @carrying)
  end

  describe "Message" do
    it "Should be silly if we can't find the word" do
      vi, wi, message = @house.get_message("SPRAY", "paint")
      vi.should == 20
      wi.should be_nil
      message.should eql("That's silly")
    end

    it "Should require two words" do
      vi, wi, message = @house.get_message("SPRAY", "")
      wi.should be_nil
      message.should eql("I need two words")
    end

    it "If it doesn't find the verb and object" do
      vi, wi, message = @house.get_message("FOO", "BAR")
      message.should eql("You don't make sense")
    end

    it "Check whether you are carrying" do
      vi, wi, message = @house.get_message("USE", "Matches")
      message.should eql("You don't have Matches")
    end

    it "Check going a direction" do
      vi, wi, message = @house.get_message("GO", "North")
      message.should be_nil
      vi.should == 2
      wi.should == 18
    end
  end

  describe "Get take" do
    it "Can't take objects from directions up" do
      check_cant_get_take(57, 18)
      check_cant_get_take(57, 23)
      check_cant_get_take(57, 35)
      check_cant_get_take(57, Random.new.rand(17) + 18)
    end

    def check_cant_get_take(start_room, object)
      HauntedHouse.new(start_room, HauntedHouse.default_flags, [])
      name = @house.objects[object]
      @house.get_take(object)
      @house.message.should eql("I can't get #{name}")
    end
  end

  describe "Carrying" do
    it "Check create carrying" do
      result = @house.create_carrying([false, true], ["Steam", "Shovel"])
      result.should eql(["Shovel"])
    end
  end
end
