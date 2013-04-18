require "oo/haunted_house"

describe 'spray command' do
  context "rear turret" do
    before { @house = Oo::HauntedHouse.new(13) }
    specify { @house.current_room.description.should eql("Rear Turret Room") }
    specify { @house.current_room.can_have_bats.should be_true }

    context "has bats" do
      before do
        Random.any_instance.stub(:rand).with(any_args).and_return(1)
      end
      specify { @house.current_room.bats.should be_true }

      context "spray bats" do
        before { spray("bats") }
        specify { @message.should eql("Hissss") }

        context "try to move" do
          before do
            @message, @next_room = @house.current_room.go_direction(Oo::Direction::W)
          end
          specify { @message.should eql("Bats Attacking!") }
          specify { @next_room.description.should eql("Rear Turret Room") }
        end

        context "with aerosol" do
          before do
            @house.carry(Oo::Inventory::AEROSOL)
            spray("bats")
          end
          specify { @house.current_room.can_have_bats.should be_false }
          specify { @house.current_room.bats.should be_false }
          specify { @message.should eql("Pfft! Got them.") }
        end
      end
    end
  end

  def spray(word)
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input(" spray #{word}")
  end

end
