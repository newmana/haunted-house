require File.dirname(__FILE__) + "/../../../../lib/oo/haunted_house"

describe 'climb command' do
  context "blasted tree" do
    before { @house = OO::HauntedHouse.new(7) }

    specify "should have correct description" do
      @house.current_room.description.should eql("Blasted Tree")
    end

    context "climb up rope" do
      before { climb }
      specify { @message.should eql("You see a thick forest and a cliff south.") }
    end

    context "climb down rope" do
      before { climb; climb }
      specify { @message.should eql("Going down!") }
    end
  end

  context "other room" do
    before { @house = OO::HauntedHouse.new(0) }

    context "climb rope" do
      before do
        @house.carry(Inventory::ROPE)
        climb
      end
      specify { @message.should eql("It isn't attached to anything!") }
    end
  end

  def climb
    parser = Parser.new(@house)
    @message = parser.parse_input("climb rope")
  end
end
