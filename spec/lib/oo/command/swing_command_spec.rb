require "oo/haunted_house"

describe 'swing command' do

  context "study with a desk" do
    before { @house = Oo::HauntedHouse.new(43) }

    specify "should have correct description" do
      @house.rooms.current_room.description.should eql("Study with a Desk and Hole in the Wall")
    end

    context "swing axe" do
      before { swing(Oo::Things::AXE) }
      specify { @message.should eql("You broke the thin wall.") }
      specify { @house.rooms.current_room.description.should eql("Study with a secret room.") }
      specify { @house.rooms.current_room.routes.keys.should =~ [Oo::Direction::W, Oo::Direction::N] }
    end
  end

  context "blasted tree" do
    before { @house = Oo::HauntedHouse.new(7) }

    specify "should have correct description" do
      @house.rooms.current_room.description.should eql("Blasted Tree")
    end

    context "swing rope" do
      before { swing(Oo::Things::ROPE) }
      specify { @message.should eql("This is no time to play games.") }
    end
  end

  context "other room" do
    before { @house = Oo::HauntedHouse.new(0) }

    context "swing axe" do
      before { swing(Oo::Things::AXE) }
      specify { @message.should eql("Whoosh") }
    end

    context "swing rope" do
      before { swing(Oo::Things::ROPE) }
      specify { @message.should eql("You swung it") }
    end
  end

  def swing(item)
    @house.inventory.carry(item)
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input("swing #{item.to_s}")
  end

end
