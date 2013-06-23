require "oo/haunted_house"

describe 'say command' do
  context "very cold chamber" do
    before { @house = Oo::HauntedHouse.new(45) }

    specify "should have correct description" do
      @house.rooms.current_room.description.should eql("Very Cold Chamber")
    end

    context "say xzanfar" do
      before { say("XZANFAR") }
      specify { @message.should eql("*Magic Occurs*") }
      specify { @house.rooms.current_room.description.should eql("Very Cold Chamber") }
    end
  end

  context "other room" do
    before do
      @house = Oo::HauntedHouse.new(0)
      fake_random = mock(Random)
      fake_random.should_receive(:rand).with(64).and_return(1)
      Random.stub!(:new).and_return(fake_random)
    end

    context "say xzanfar" do
      before { say("XZANFAR") }
      specify { @message.should eql("*Magic Occurs*") }
      specify { @house.rooms.current_room.description.should eql("Overgrown Garden") }
    end
  end

  def say(word)
    @house.inventory.carry(Oo::Things::MAGIC_SPELLS)
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input("say #{word}")
  end
end
