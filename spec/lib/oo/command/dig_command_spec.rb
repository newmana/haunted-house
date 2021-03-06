require "oo/haunted_house"

describe 'dig command' do
  context "cellar with barred window" do
    before { @house = Oo::HauntedHouse.new(30) }

    specify "should have correct description" do
      @house.rooms.current_room.description.should eql("Cellar with Barred Window")
    end

    context "dig" do
      before { dig }
      specify { @message.should eql("Dug the bars out.") }
      specify { @house.rooms.current_room.description.should eql("Hole in the wall.") }
      specify { @house.rooms.current_room.routes.keys.should =~ [Oo::Direction::U, Oo::Direction::S, Oo::Direction::N,
        Oo::Direction::E] }
    end
  end

  context "other room" do
    before { @house = Oo::HauntedHouse.new(0) }

    context "dig" do
      before { dig }
      specify { @message.should eql("You've made a hole.") }
    end
  end

  def dig
    @house.rooms.inventory.carry(Oo::Things::SHOVEL)
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input("dig")
  end
end
