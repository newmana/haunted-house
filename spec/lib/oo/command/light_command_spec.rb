require "oo/haunted_house"

describe 'light command' do
  context "room" do
    before { @house = Oo::HauntedHouse.new(0) }

    context "light candle no candlestick or matches" do
      before do
        @house.rooms.inventory.carry(Oo::Things::CANDLE)
        light_candle
      end
      specify { @message.should eql("Nothing to light it with.") }

      context "light candle no matches" do
        before do
          @house.rooms.inventory.carry(Oo::Things::CANDLESTICK)
          light_candle
        end

        specify { @message.should eql("Nothing to light it with.") }

        context "light candle" do
          before do
            @house.rooms.inventory.carry(Oo::Things::MATCHES)
            light_candle
          end

          specify { @message.should eql("It casts a flickering light.") }
        end
      end

      context "light candle no candlestick" do
        before do
          @house.rooms.inventory.carry(Oo::Things::MATCHES)
          light_candle
        end

        specify { @message.should eql("It will burn your hands.") }
      end
    end
  end

  def light_candle
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input("light candle")
  end
end
