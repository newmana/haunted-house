require 'haunted_house'

describe 'haunted house' do
  before(:all) do
    @carrying = []
    @house = HauntedHouse.new(57, HauntedHouse.default_flags, @carrying)
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
    it "Can't take objects from north (18) on" do
      [18, 23, 35, Random.new.rand(17) + 18]. each { |r| check_cant_get_take(r) }
    end

    it "Check location of object" do
      h = HauntedHouse.new(57, HauntedHouse.default_flags, [])
      h.get_take(0)
      h.message.should eql("It isn't here")
    end

    it "Check flag" do
      @house.get_take(2)
      @house.message.should eql("What #{@house.objects[2]}?")
    end

    it "Check flag" do
      h = HauntedHouse.new(57, HauntedHouse.default_flags, [true])
      h.get_take(0)
      h.message.should eql("You already have it")
    end

    it "Check flag" do
      h = HauntedHouse.new(46, HauntedHouse.default_flags, [])
      h.get_take(0)
      h.message.should eql("You have the #{h.objects[0]}")
    end

    def check_cant_get_take(object)
      name = @house.objects[object]
      @house.get_take(object)
      @house.message.should eql("I can't get #{name}")
    end
  end

  describe "Open" do
    it "Drawer" do
      h = HauntedHouse.new(43, HauntedHouse.default_flags, [])
      h.flags[17].should be_true
      check_open(h, 27, "Drawer open")
      h.flags[17].should be_false
    end

    it "Desk" do
      h = HauntedHouse.new(43, HauntedHouse.default_flags, [])
      h.flags[17].should be_true
      check_open(h, 28, "Drawer open")
      h.flags[17].should be_false
    end

    it "Doors" do
      h = HauntedHouse.new(28, HauntedHouse.default_flags, [])
      check_open(h, 24, "It's locked")
    end

    it "Coffin" do
      h = HauntedHouse.new(38, HauntedHouse.default_flags, [])
      check_open(h, 31, "That's creepy!")
      h.flags[2].should be_false
    end

    def check_open(h, object, message)
      h.open(object)
      h.message.should eql(message)
    end
  end

  describe "Carrying" do
    it "Check create carrying" do
      result = @house.create_carrying([false, true], ["Steam", "Shovel"])
      result.should eql(["Shovel"])
    end
  end
end
