require 'haunted_house'

describe 'haunted house' do
  describe "Message" do
    it "Should be silly if we can't find the word" do
      in_the_house { |h|
        vi, wi = h.parse("SPRAY paint")
        vi.should == 20
        wi.should be_nil
        h.message.should eql("That's silly")
      }
    end

    it "Should require two words" do
      in_the_house { |h|
        vi, wi = h.parse("SPRAY")
        vi.should == 20
        wi.should be_nil
        h.message.should eql("I need two words")
      }
    end

    it "If it doesn't find the verb and object" do
      in_the_house { |h|
        vi, wi = h.parse("FOO BAR")
        vi.should be_nil
        wi.should be_nil
        h.message.should eql("You don't make sense")
      }
    end

    it "Check whether you are carrying" do
      in_the_house { |h|
        vi, wi = h.parse("USE MATCHES")
        vi.should == 21
        wi.should == 8
        h.message.should eql("You don't have Matches")
      }
    end

    it "Check going a direction" do
      in_the_house { |h|
        vi, wi = h.parse("GO NORTH")
        vi.should == 2
        wi.should == 18
        h.message.should eql("Ok")
      }
    end
  end

  describe "Get take" do
    it "Can't take objects from north (18) on" do
      [18, 23, 35, Random.new.rand(17) + 18].each { |r| check_cant_get_take(r) }
    end

    def check_cant_get_take(object)
      in_the_house { |h|
        name = h.objects[object]
        h.get_take(object)
        h.message.should eql("I can't get #{name}")
      }
    end

    it "Check location of object" do
      in_the_house { |h|
        h.parse("take painting")
        h.message.should eql("It isn't here")
      }
    end

    it "Check flag" do
      in_the_house { |h|
        h.parse("take magic spells")
        h.message.should eql("What #{h.objects[2]}?")
      }
    end

    it "Check flag" do
      in_the_house(57, HauntedHouse.default_flags, [true]) { |h|
        h.parse("take painting")
        h.message.should eql("You already have it")
      }
    end

    it "Check flag" do
      in_the_house(46) { |h|
        h.parse("take painting")
        h.message.should eql("You have the #{h.objects[0]}")
      }
    end
  end

  describe "Open" do
    it "Drawer" do
      in_the_house(43) { |h|
        h.flags[17].should be_true
        check_open(h, "drawer", "Drawer open")
        h.flags[17].should be_false
      }
    end

    it "Desk" do
      in_the_house(43) { |h|
        h.flags[17].should be_true
        check_open(h, "desk", "Drawer open")
        h.flags[17].should be_false
      }
    end

    it "Doors" do
      in_the_house(28) { |h|
        check_open(h, "doors", "It's locked")
      }
    end

    it "Coffin" do
      in_the_house(38) { |h|
        check_open(h, "coffin", "That's creepy!")
        h.flags[2].should be_false
      }
    end

    def check_open(h, object, message)
      h.parse("open #{object}")
      h.message.should eql(message)
    end
  end

  describe "Examine" do
    it "Drawer or Desk" do
      in_the_house(43) { |h|
        check_examine(h, "drawer", "There is a drawer")
        check_examine(h, "desk", "There is a drawer")
      }
    end

    it "Coat" do
      in_the_house { |h|
        h.flags[18].should be_true
        check_examine(h, "coat", "Something here!")
        h.flags[18].should be_false
      }
    end

    it "Rubbish" do
      in_the_house { |h|
        check_examine(h, "rubbish", "That's disgusting!")
      }
    end

    it "Wall" do
      in_the_house(43) { |h|
        check_examine(h, "wall", "There's something beyond")
      }
    end

    def check_examine(h, object, message)
      h.parse("examine #{object}")
      h.message.should eql(message)
    end
  end

  describe "Read" do
    it "Books" do
      in_the_house(42) { |h|
        check_read(h, "books", "They are demonic works.")
      }
    end

    it "Magic Spells or Spells" do
      carrying = []
      carrying[2] = true
      in_the_house(42, HauntedHouse.default_flags, carrying) { |h|
        xzanfar = "Use this word with care 'Xzanfar'."
        check_read(h, "magic spells", xzanfar)
        check_read(h, "spells", xzanfar)
      }
    end

    it "Scroll" do
      carrying = []
      carrying[0] = true
      in_the_house(42, HauntedHouse.default_flags, carrying) { |h|
        check_read(h, "scroll", "The script is in an alien tongue.")
      }
    end

    def check_read(h, object, message)
      h.parse("read #{object}")
      h.message.should eql(message)
    end
  end

  describe "Say" do
    it "Anything" do
      in_the_house { |h|
        check_say(h, "anything", "Ok Anything")
      }
    end

    describe "Xzanfar" do
      before(:each) do
        @carrying = []
        @carrying[2] = true
      end

      it "Xzanfar with Goblet not in Chamber" do
        in_the_house(-1, HauntedHouse.default_flags, @carrying) { |h|
          check_say(h, "Xzanfar", "*Magic Occurs*")
          (0..63).should include(h.room)
        }
      end

      it "Xzanfar with Goblet in Cold Chamber" do
        in_the_house(45, HauntedHouse.default_flags, @carrying) { |h|
          h.flags[33].should be_false
          check_say(h, "Xzanfar", "*Magic Occurs*")
          h.flags[33].should be_true
          (0..63).should include(h.room)
        }
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
      @carrying[11] = true
    end

    it "Dig in any room" do
      in_the_house(1, HauntedHouse.default_flags, @carrying) { |h|
        h.parse("dig")
        h.message.should eql("You've made a hole.")
      }
    end

    it "Dig in cellar" do
      in_the_house(30, HauntedHouse.default_flags, @carrying) { |h|
        h.parse("dig")
        h.message.should eql("Dug the bars out.")
        h.descriptions[30].should eql("Hole in the wall.")
      }
    end
  end

  describe "Swing" do
    describe "Axe" do
      before(:each) do
        @carrying = []
        @carrying[12] = true
      end

      it "With axe but not in study" do
        in_the_house(57, HauntedHouse.default_flags, @carrying) { |h|
          h.parse("swing axe")
          h.message.should eql("Whoosh")
        }
      end

      it "With axe in study" do
        in_the_house(43, HauntedHouse.default_flags, @carrying) { |h|
          h.parse("swing axe")
          h.message.should eql("You broke the thin wall.")
          h.descriptions[43].should eql("Study with a secret room.")
        }
      end
    end

    describe "Rope" do
      before(:each) do
        @carrying = []
        @carrying[13] = true
      end

      it "With tree" do
        in_the_house(7, HauntedHouse.default_flags, @carrying) { |h|
          h.parse("swing rope")
          h.message.should eql("This is no time to play games.")
        }
      end

      it "Without tree" do
        in_the_house(57, HauntedHouse.default_flags, @carrying) { |h|
          h.parse("swing rope")
          h.message.should eql("You swung it")
        }
      end
    end
  end

  describe "Climb" do
    describe "Rope" do
      before(:each) do
        @carrying = []
        @carrying[13] = true
      end

      it "Unattached rope" do
        in_the_house(57, HauntedHouse.default_flags, @carrying) { |h|
          h.parse("climb rope")
          h.message.should eql("It isn't attached to anything!")
        }
      end

      it "Rope with blasted tree" do
        in_the_house(7, HauntedHouse.default_flags, []) { |h|
          h.flags[14].should be_false
          h.parse("climb rope")
          h.message.should eql("You see a thick forest and a cliff south.")
          h.flags[14].should be_true
          h.parse("climb rope")
          h.message.should eql("Going down.")
          h.flags[14].should be_false
        }
      end
    end
  end

  describe "Carrying" do
    it "Check create carrying" do
      in_the_house { |h|
        result = h.create_carrying([false, true], ["Steam", "Shovel"])
        result.should eql(["Shovel"])
      }
    end
  end

  def in_the_house(room=57, flags=HauntedHouse.default_flags, carrying=[])
    h = HauntedHouse.new(room, flags, carrying)
    yield(h)
  end
end
