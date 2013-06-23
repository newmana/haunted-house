require "oo/haunted_house"

describe 'carrying command' do
  context "not carrying anything" do
    before do
      @house = Oo::HauntedHouse.new
    end

    specify do
      Oo::Command::CarryingCommand.any_instance.stub(:display_list).with("You are carrying:", [])
      carrying
    end
  end

  context "other room" do
    before do
      @house = Oo::HauntedHouse.new(0)
      @house.inventory.carry(Oo::Things::ROPE)
    end

    specify do
      Oo::Command::CarryingCommand.any_instance.stub(:display_list).with("You are carrying:", [Oo::Things::ROPE])
      carrying
    end
  end

  def carrying
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input("carrying?")
  end
end
