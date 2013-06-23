require "oo/haunted_house"

describe 'unlock command' do
  context "study" do
    before { @house = Oo::HauntedHouse.new(43) }

    specify "should have correct description" do
      @house.current_room.description.should eql("Study with a Desk and Hole in the Wall")
    end

    context "unlock desk" do
      before { unlock("desk") }
      specify { @message.should eql("Drawer open.") }
      specify { @house.current_room.objects.should =~ [Oo::Things::CANDLE] }
    end

    context "unlock drawer" do
      before { unlock("drawer") }
      specify { @message.should eql("Drawer open.") }
      specify { @house.current_room.objects.should =~ [Oo::Things::CANDLE] }
    end
  end

  context "hall" do
    before { @house = Oo::HauntedHouse.new(28) }

    specify "should have correct description" do
      @house.current_room.description.should eql("Hall by a Thick Wooden Door")
    end

    context "unsuccessful unlock door" do
      before { unlock("door") }
      specify { @message.should eql("It's locked.") }
      specify { @house.current_room.description.should eql("Hall by a Thick Wooden Door") }
    end

    context "successful unlock door" do
      before do
        @house.inventory.carry(Oo::Things::KEY)
        unlock("door")
      end
      specify { @house.current_room.description.should eql("Huge open door.") }
      specify { @message.should eql("The key turns!") }
    end
  end

  def unlock(object)
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input("unlock #{object}")
  end
end
