require File.dirname(__FILE__) + "/../../../../lib/oo/haunted_house"

describe 'spray command' do
  context "rear turret" do
    before { @house = OO::HauntedHouse.new(13) }
    specify { @house.current_room.description.should eql("Rear Turret Room") }
    specify { @house.current_room.can_have_bats.should be_true }

    context "has bats" do
      before do
        fake_random = mock(Random)
        fake_random.should_receive(:rand).with(3).and_return(1)
        Random.stub!(:new).and_return(fake_random)
      end

      specify { @house.current_room.bats.should be_true }
    end

    context "spray bats" do
      before { spray("bats") }
      specify { @house.current_room.can_have_bats.should be_true }

      context "with aerosol" do
        before do
          @house.carry(Inventory::AEROSOL)
          spray("bats")
        end
        specify { @house.current_room.can_have_bats.should be_false }
        specify { @house.current_room.bats.should be_false }
      end
    end
  end

  def spray(word)
    parser = Parser.new(@house)
    @message = parser.parse_input("spray #{word}")
  end

end
