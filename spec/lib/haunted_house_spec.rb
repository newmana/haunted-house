require 'spec_helper'
require 'haunted_house'

describe 'haunted house' do
  describe "Message" do
    it "be silly if we can't find the word" do
      in_the_house do |h|
        vi, wi = h.parse("SPRAY paint")
        vi.should == 21
        wi.should be_nil
        h.message.should eql("That's silly")
      end
    end

    it "require two words" do
      in_the_house do |h|
        vi, wi = h.parse("SPRAY")
        vi.should == 21
        wi.should be_nil
        h.message.should eql("I need two words")
      end
    end

    it "you can't if the verb is wrong but the object is correct" do
      in_the_house do |h|
        vi, wi = h.parse("george AEROSOL")
        vi.should be_nil
        wi.should == 16
        h.message.should eql("You can't 'GEORGE Aerosol'")
      end
    end

    it "If it doesn't find the verb and object" do
      in_the_house do |h|
        vi, wi = h.parse("FOO BAR")
        vi.should be_nil
        wi.should be_nil
        h.message.should eql("You don't make sense")
      end
    end

    it "Check whether you are carrying" do
      in_the_house do |h|
        vi, wi = h.parse("USE MATCHES")
        vi.should == 22
        wi.should == 9
        h.message.should eql("You don't have Matches")
      end
    end

    it "Check going a direction" do
      in_the_house do |h|
        vi, wi = h.parse("GO NORTH")
        vi.should == 3
        wi.should == 19
        h.message.should eql("Ok")
      end
    end
  end

  describe "Move" do
    it "Too Dark to do so" do
      (26..30).each { |i| check_too_dark(i) }
    end

    def check_too_dark(room)
      in_the_house(room) do |h|
        h.parse("n")
        h.message.should eql("Too dark to move.")
      end
    end

    it "Magic barrier" do
      in_the_house(45, HauntedHouse.default_flags, [false, true, false, true]) do |h|
        h.flags[34].should be_false
        h.parse("w")
        h.message.should eql("A magical barrier to the west.")
        h.parse("say xzanfar")
        h.flags[34].should be_true
        h.message.should eql("*Magic Occurs*")
        h.parse("w")
        h.message.should eql("Ok")
        h.room.should == 44
      end
    end

    describe "Boat" do
      before(:each) do
        @carrying = []
        @carrying[15] = true
      end

      it "Can move" do
        check_can_move_boat(53, "s", @carrying)
        check_can_move_boat(54, "s", @carrying)
        check_can_move_boat(55, "n", @carrying)
        check_can_move_boat(47, "n", @carrying)
      end

      it "Cannot move" do
        check_cannot_move_boat(52, "n", @carrying)
        check_cannot_move_boat(56, "n", @carrying)
        check_cannot_move_boat(46, "w", @carrying)
        check_cannot_move_boat(48, "e", @carrying)
      end
    end

    def check_can_move_boat(room, direction, carrying)
      check_boat(room, carrying, direction, "Ok")
    end

    def check_cannot_move_boat(room, direction, carrying)
      check_boat(room, carrying, direction, "You can't carry a boat!")
    end

    def check_boat(room, carrying, direction, message)
      in_the_house(room, HauntedHouse.default_flags, carrying) do |h|
        h.parse(direction)
        h.message.should eql(message)
      end
    end
  end

  describe "Carrying" do
    it "Check create carrying" do
      in_the_house do |h|
        result = h.create_carrying([false, true], ["Steam", "Shovel"])
        result.should eql(["Shovel"])
      end
    end
  end

  describe "Get take" do
    it "Can't take objects from north (19) on" do
      [19, 24, 36, Random.new.rand(17) + 19].each { |r| check_cant_get_take(r) }
    end

    def check_cant_get_take(object)
      in_the_house do |h|
        name = h.objects[object]
        h.get_take(object)
        h.message.should eql("I can't get #{name}")
      end
    end

    it "Check location of object" do
      in_the_house do |h|
        h.parse("take painting")
        h.message.should eql("It isn't here")
      end
    end

    it "Check flag" do
      in_the_house do |h|
        h.parse("take ring")
        h.message.should eql("What #{h.objects[2]}?")
      end
    end

    it "Check flag" do
      in_the_house(57, HauntedHouse.default_flags, [false, true]) do |h|
        h.parse("take painting")
        h.message.should eql("You already have it")
      end
    end

    it "Check flag" do
      in_the_house(46) do |h|
        h.parse("take painting")
        h.message.should eql("You have the #{h.objects[1]}")
      end
    end
  end

  describe "Open" do
    it "Drawer" do
      in_the_house(43) do |h|
        h.flags[17].should be_true
        check_open(h, "drawer", "Drawer open.")
        h.flags[17].should be_false
      end
    end

    it "Desk" do
      in_the_house(43) do |h|
        h.flags[17].should be_true
        check_open(h, "desk", "Drawer open.")
        h.flags[17].should be_false
      end
    end

    it "Doors" do
      in_the_house(28) do |h|
        check_open(h, "door", "It's locked.")
      end
    end

    it "Coffin" do
      in_the_house(38) do |h|
        check_open(h, "coffin", "That's creepy!")
        h.flags[2].should be_false
      end
    end

    def check_open(h, object, message)
      h.parse("open #{object}")
      h.message.should eql(message)
    end
  end

  describe "Examine" do
    it "Drawer or Desk" do
      in_the_house(43) do |h|
        check_examine(h, "drawer", "There is a drawer.")
        check_examine(h, "desk", "There is a drawer.")
      end
    end

    it "Coat" do
      in_the_house do |h|
        h.flags[18].should be_true
        check_examine(h, "coat", "Something here!")
        h.flags[18].should be_false
      end
    end

    it "Rubbish" do
      in_the_house do |h|
        check_examine(h, "rubbish", "That's disgusting!")
      end
    end

    it "Wall" do
      in_the_house(43) do |h|
        check_examine(h, "wall", "There's something beyond...")
      end
    end

    it "Books" do
      in_the_house(42) do |h|
        check_examine(h, "books", "They are demonic works.")
      end
    end

    it "Scroll" do
      carrying = []
      carrying[5] = true
      in_the_house(42, HauntedHouse.default_flags, carrying) do |h|
        check_examine(h, "scroll", "The script is in an alien tongue.")
      end
    end

    def check_examine(h, object, message)
      h.parse("examine #{object}")
      h.message.should eql(message)
    end
  end

  describe "Read" do
    it "Books" do
      in_the_house(42) do |h|
        check_read(h, "books", "They are demonic works.")
      end
    end

    it "Magic Spells or Spells" do
      carrying = []
      carrying[3] = true
      in_the_house(42, HauntedHouse.default_flags, carrying) do |h|
        xzanfar = "Use this word with care 'Xzanfar'."
        check_read(h, "magic spells", xzanfar)
        check_read(h, "spells", xzanfar)
      end
    end

    it "Scroll" do
      carrying = []
      carrying[5] = true
      in_the_house(42, HauntedHouse.default_flags, carrying) do |h|
        check_read(h, "scroll", "The script is in an alien tongue.")
      end
    end

    def check_read(h, object, message)
      h.parse("read #{object}")
      h.message.should eql(message)
    end
  end

  describe "Say" do
    it "Anything" do
      in_the_house do |h|
        check_say(h, "anything", "Ok Anything")
      end
    end

    describe "Xzanfar" do
      before(:each) do
        @carrying = []
        @carrying[3] = true
      end

      it "With Goblet not in Chamber" do
        in_the_house(-1, HauntedHouse.default_flags, @carrying) do |h|
          check_say(h, "Xzanfar", "*Magic Occurs*")
          (0..63).should include(h.room)
        end
      end

      it "With Goblet in Cold Chamber" do
        in_the_house(45, HauntedHouse.default_flags, @carrying) do |h|
          h.flags[34].should be_false
          check_say(h, "Xzanfar", "*Magic Occurs*")
          h.flags[34].should be_true
          (0..63).should include(h.room)
        end
      end
    end

    def check_say(h, object, message)
      h.parse("say #{object}")
      h.message.should eql(message)
    end
  end

  describe "Dig" do
    before(:each) do
      @carrying = []
      @carrying[12] = true
    end

    it "In any room" do
      in_the_house(1, HauntedHouse.default_flags, @carrying) do |h|
        h.parse("dig")
        h.message.should eql("You've made a hole.")
      end
    end

    it "In cellar" do
      in_the_house(30, HauntedHouse.default_flags, @carrying) do |h|
        h.parse("dig")
        h.message.should eql("Dug the bars out.")
        h.descriptions[30].should eql("Hole in the wall.")
      end
    end
  end

  describe "Swing" do
    describe "Axe" do
      before(:each) do
        @carrying = []
        @carrying[13] = true
      end

      it "But not in study" do
        in_the_house(57, HauntedHouse.default_flags, @carrying) do |h|
          h.parse("swing axe")
          h.message.should eql("Whoosh")
        end
      end

      it "With axe in study" do
        in_the_house(43, HauntedHouse.default_flags, @carrying) do |h|
          h.parse("swing axe")
          h.message.should eql("You broke the thin wall.")
          h.descriptions[43].should eql("Study with a secret room.")
        end
      end
    end

    describe "Rope" do
      before(:each) do
        @carrying = []
        @carrying[14] = true
      end

      it "With tree" do
        in_the_house(7, HauntedHouse.default_flags, @carrying) do |h|
          h.parse("swing rope")
          h.message.should eql("This is no time to play games.")
        end
      end

      it "Without tree" do
        in_the_house(57, HauntedHouse.default_flags, @carrying) do |h|
          h.parse("swing rope")
          h.message.should eql("You swung it")
        end
      end
    end
  end

  describe "Climb" do
    describe "Rope" do
      before(:each) do
        @carrying = []
        @carrying[14] = true
      end

      it "Unattached" do
        in_the_house(57, HauntedHouse.default_flags, @carrying) do |h|
          h.parse("climb rope")
          h.message.should eql("It isn't attached to anything!")
        end
      end

      it "With blasted tree" do
        in_the_house(7, HauntedHouse.default_flags, []) do |h|
          h.flags[14].should be_false
          h.parse("climb rope")
          h.message.should eql("You see a thick forest and a cliff south.")
          h.flags[14].should be_true
          h.parse("climb rope")
          h.message.should eql("Going down!")
          h.flags[14].should be_false
        end
      end
    end
  end

  describe "Light" do
    it "candle without candle stick" do
      check_light_candle(false, false, "Nothing to light it with.", false)
    end

    it "candle without matches but with candle stick" do
      check_light_candle(true, false, "Nothing to light it with.", false)
    end

    it "candle without candle stick but with matches" do
      check_light_candle(false, true, "It will burn your hands.", false)
    end

    it "candle with candle stick and matches" do
      check_light_candle(true, true, "It casts a flickering light.", true)
    end

    def check_light_candle(candle_stick, matches, expected_message, expected_flag)
      carrying = []
      carrying[18] = true
      carrying[8] = candle_stick
      carrying[9] = matches
      in_the_house(7, HauntedHouse.default_flags, carrying) do |h|
        h.parse("light candle")
        h.message.should eql(expected_message)
        h.flags[0].should == expected_flag
      end
    end
  end

  describe "Unlight" do
    it "anything" do
      flags = []
      flags[0] = true
      in_the_house(57, flags, []) do |h|
        h.parse("unlight")
        h.message.should eql("Extinguished.")
        h.flags[0].should be_false
      end
    end
  end

  describe "Unlock" do
    it "Drawer" do
      in_the_house(43) do |h|
        h.flags[17].should be_true
        check_unlock(h, "drawer", "Drawer open.")
        h.flags[17].should be_false
      end
    end

    it "Desk" do
      in_the_house(43) do |h|
        h.flags[17].should be_true
        check_unlock(h, "desk", "Drawer open.")
        h.flags[17].should be_false
      end
    end

    it "Door" do
      carrying = []
      carrying[18] = true
      in_the_house(28, HauntedHouse.default_flags, carrying) do |h|
        h.parse("unlock door")
        h.descriptions[28].should eql("Huge open door.")
        h.message.should eql("The key turns!")
      end
    end

    def check_unlock(h, object, message)
      h.parse("unlock #{object}")
      h.message.should eql(message)
    end
  end

  describe "Score" do
    it "Has everything but boat" do
      check_score(1)
    end

    #it "Has everything at start" do
    #  check_score(57)
    #end

    def check_score(room)
      carrying = []
      (1..18).each_with_index { |n, i| carrying[i] = true unless i == 15 }
      in_the_house(room, HauntedHouse.default_flags, carrying) do |h|
        h.parse("score")
      end
    end
  end

  def in_the_house(room=57, flags=HauntedHouse.default_flags, carrying=[])
    h = HauntedHouse.new(room, flags, carrying)
    yield(h)
  end
end
