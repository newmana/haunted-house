require "oo/haunted_house"

describe 'get/take command' do
  context "leave rope" do
    before do
      @house = Oo::HauntedHouse.new(0)
      @house.rooms.inventory.carry(Oo::Things::ROPE)
      leave("rope")
    end

    specify { @message.should eql("Done") }
  end

  def leave(thing)
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input("leave #{thing}")
  end
end
