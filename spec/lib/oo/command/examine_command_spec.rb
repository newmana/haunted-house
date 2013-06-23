require "oo/haunted_house"

describe 'examine command' do
  context "study" do
    before { @house = Oo::HauntedHouse.new(43) }

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
    before { @house = Oo::HauntedHouse.new(32) }

    specify "should have correct description" do
      @house.current_room.description.should eql("Cupboard with Hanging Coat")
    end

    context "examine coat" do
      before { examine("coat") }
      specify { @message.should eql("Something here!") }
      specify { @house.current_room.objects.should =~ [Oo::Things::KEY] }
    end

    context "examine scroll" do
      before do
        @house.inventory.carry(Oo::Things::SCROLL)
        examine("scroll")
      end
      specify { @message.should eql("The script is in an alien tongue.") }
    end
  end

  context "yard" do
    before { @house = Oo::HauntedHouse.new(3) }

    specify "should have correct description" do
      @house.current_room.description.should eql("Yard by Rubbish")
    end

    context "examine rubbish" do
      before { examine("rubbish") }
      specify { @message.should eql("That's disgusting!") }
    end
  end

  context "library" do
    before { @house = Oo::HauntedHouse.new(42) }

    specify "should have correct description" do
      @house.current_room.description.should eql("Library of Evil Books")
    end

    context "read books" do
      before { examine("books") }
      specify { @message.should eql("They are demonic works.") }
    end
  end

  context "cellar with coffin" do
    before { @house = Oo::HauntedHouse.new(38) }

    specify "should have correct description" do
      @house.current_room.description.should eql("Deep Cellar with a Coffin")
    end

    context "examine coffin" do
      before { examine("coffin") }
      specify { @message.should eql("That's creepy!") }
      specify { @house.current_room.objects.should =~ [Oo::Things::RING] }
    end
  end

  def examine(object)
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input("examine #{object}")
  end
end
