require File.dirname(__FILE__) + "/../../../../lib/oo/haunted_house"

describe 'examine command' do
  context "study" do
    before { @house = OO::HauntedHouse.new(43) }

    specify "should have correct description" do
      @house.current_room.description.should eql("Study with a Desk and Hole in the Wall")
    end

    context "examine desk" do
      before { examine("desk") }
      specify { @message.should eql("There is a drawer.") }
    end

    context "examine drawer" do
      before { examine("drawer") }
      specify { @message.should eql("There is a drawer.") }
    end

    context "examine wall" do
      before { examine("wall") }
      specify { @message.should eql("There's something beyond...") }
    end
  end

  context "cupboard" do
    before { @house = OO::HauntedHouse.new(32) }

    specify "should have correct description" do
      @house.current_room.description.should eql("Cupboard with Hanging Coat")
    end

    context "examine coat" do
      before { examine("coat") }
      specify { @message.should eql("Something here!") }
      specify { @house.current_room.objects.should =~ [Inventory::KEY] }
    end
  end

  def examine(object)
    parser = Parser.new(@house)
    @message = parser.parse_input("examine #{object}")
  end
end
