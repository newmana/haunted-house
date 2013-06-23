require "oo/haunted_house"

describe 'unlight command' do
  context "room" do
    before { @house = Oo::HauntedHouse.new(0) }

    context "light candle no candlestick or matches" do
      before do
        @house.rooms.inventory.carry(Oo::Things::CANDLE)
        @house.rooms.inventory.carry(Oo::Things::CANDLESTICK)
        @house.rooms.inventory.carry(Oo::Things::MATCHES)
        @house.rooms.inventory.thing(Oo::Things::CANDLE).light(@house.rooms.inventory)
        unlight_candle
      end

      specify { @message.should eql("Extinguished.") }
    end
  end

  def unlight_candle
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input("unlight candle")
  end
end
