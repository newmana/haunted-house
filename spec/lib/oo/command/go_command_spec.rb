require "oo/haunted_house"

describe 'go command' do
  context "start" do
    before { @house = Oo::HauntedHouse.new }

    context "go north" do
      before { go("go north") }

      specify "ok" do
        @message.should eql("Ok")
      end
    end

    context "n" do
      before { go("n") }

      specify "ok" do
        @message.should eql("Ok")
      end
    end

    context "go wrong name for a direction" do
      before { go("go whereever") }

      specify "where" do
        @message.should eql("Go where?")
      end
    end
  end

  context "You need a light going north or east" do
    before { @house = Oo::HauntedHouse.new(26) }

    specify "try go north" do
      go("n")
      @message.should eql("You need a light.")
    end

    specify "try go east" do
      go("e")
      @message.should eql("You need a light.")
    end

    context "with a lit candle move" do
      before do
        @house.inventory.carry(Oo::Things::CANDLE)
        @house.inventory.carry(Oo::Things::CANDLESTICK)
        @house.inventory.carry(Oo::Things::MATCHES)
        @house.inventory.thing("candle").light(@house)
      end

      specify "try go north" do
        go("n")
        @message.should eql("Ok")
      end

      specify "try go east" do
        go("e")
        @message.should eql("Ok")
      end
    end
  end

  context "You need a light in a dark room" do
    specify "try go north" do
      (27..29).each do |room|
        @house = Oo::HauntedHouse.new(room)
        go("n")
        @message.should eql("Too dark to move.")
      end
    end

    context "with lit candle" do
      specify "try go north" do
        (27..29).each do |room|
          @house = Oo::HauntedHouse.new(room)
          @house.inventory.carry(Oo::Things::CANDLE)
          @house.inventory.carry(Oo::Things::CANDLESTICK)
          @house.inventory.carry(Oo::Things::MATCHES)
          @house.inventory.thing("candle").light(@house)
          go("w")
          @message.should eql("Ok")
        end
      end

    end
  end

  context "bottom of spiral staircase" do
    before { @house = Oo::HauntedHouse.new(20) }
    specify { @house.current_room.description.should eql("Bottom of a Spiral Staircase") }

    context "go up" do
      before { go("go up") }
      specify { @message.should eql("Ok") }
      specify { @house.current_room.description.should eql("Room with Inches of Dust") }
    end

    context "go down" do
      before { go("go down") }
      specify { @message.should eql("Ok") }
      specify { @house.current_room.description.should eql("Small Dark Room") }
    end
  end

  context "slippery steps" do
    before { @house = Oo::HauntedHouse.new(22) }
    specify { @house.current_room.description.should eql("Slippery Steps") }

    context "go up" do
      before { go("go up") }
      specify { @message.should eql("Ok") }
      specify { @house.current_room.description.should eql("Wide Passage") }
    end

    context "go down" do
      before { go("go down") }
      specify { @message.should eql("Ok") }
      specify { @house.current_room.description.should eql("Cellar with Barred Window") }
    end
  end

  context "slippery steps" do
    before { @house = Oo::HauntedHouse.new(36) }
    specify { @house.current_room.description.should eql("Steep Marble Stairs") }

    context "go up" do
      before { go("go up") }
      specify { @message.should eql("Ok") }
      specify { @house.current_room.description.should eql("Weird Cobwebby Room") }
    end

    context "go down" do
      before { go("go down") }
      specify { @message.should eql("Ok") }
      specify { @house.current_room.description.should eql("Hall by a Thick Wooden Door") }
    end
  end

  context "marsh" do
    before { @house = Oo::HauntedHouse.new(54) }
    specify { @house.current_room.description.should eql("Marsh") }

    context "without boat" do
      before { go("go south") }
      specify { @message.should eql("You're stuck!") }
      specify { @house.current_room.description.should eql("Marsh") }
    end
  end

  context "around marsh" do
    before do
      [53, 54, 55, 47].each do |room|
        @house = Oo::HauntedHouse.new(room)
        @house.inventory.carry(Oo::Things::BOAT)
        go("go south")
        @message.should eql("Ok")
      end
    end
  end

  context "can't carry boat outside marsh" do
    before do
      @house = Oo::HauntedHouse.new(1)
      @house.inventory.carry(Oo::Things::BOAT)
    end

    specify do
      go("go west")
      @message.should eql("You can't carry a boat!")
    end
  end

  def go(direction)
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input("#{direction}")
  end

end
