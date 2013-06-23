require "oo/haunted_house"

describe 'open command' do
  context "study" do
    before { @house = Oo::HauntedHouse.new(43) }

    specify "should have correct description" do
      @house.rooms.current_room.description.should eql("Study with a Desk and Hole in the Wall")
    end

    context "open desk" do
      before { open("desk") }
      specify { @message.should eql("Drawer open.") }
      specify { @house.rooms.current_room.objects.should =~ [Oo::Things::CANDLE] }
    end

    context "open drawer" do
      before { open("drawer") }
      specify { @message.should eql("Drawer open.") }
      specify { @house.rooms.current_room.objects.should =~ [Oo::Things::CANDLE] }
    end
  end

  context "study" do
    before { @house = Oo::HauntedHouse.new(28) }

    specify "should have correct description" do
      @house.rooms.current_room.description.should eql("Hall by a Thick Wooden Door")
    end

    context "open door" do
      before { open("door") }
      specify { @message.should eql("It's locked.") }
    end
  end

  context "cellar with coffin" do
    before { @house = Oo::HauntedHouse.new(38) }

    specify "should have correct description" do
      @house.rooms.current_room.description.should eql("Deep Cellar with a Coffin")
    end

    context "open coffin" do
      before { open("coffin") }
      specify { @message.should eql("That's creepy!") }
      specify { @house.rooms.current_room.objects.should =~ [Oo::Things::RING] }
    end
  end

  def open(object)
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input("open #{object}")
  end
end
