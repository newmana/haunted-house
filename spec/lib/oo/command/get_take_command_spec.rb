require "oo/haunted_house"

describe 'get/take command' do
  context "in cupboard" do
    before do
      @house = Oo::HauntedHouse.new(32)
      @house.current_room.objects << Oo::Things::KEY
    end

    specify { @house.current_room.description.should eql("Cupboard with Hanging Coat") }

    context "get/take key" do
      before { get("key") }
      specify { @message.should eql("You have the KEY") }
      specify { @house.inventory.time }
    end
  end

  context "front tower" do
    before do
      @house = Oo::HauntedHouse.new(50)
    end

    specify { @house.current_room.description.should eql("Front Tower") }

    context "get/take goblet" do
      before { get("goblet") }
      specify { @message.should eql("You have the GOBLET") }
      specify { @house.inventory.time }
    end
  end

  def get(word)
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input(" get #{word}")
  end

end
