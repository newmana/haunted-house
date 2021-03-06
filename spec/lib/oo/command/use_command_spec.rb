require 'spec_helper'
require 'oo/haunted_house'

describe 'use command' do
  context "anywhere" do
    before do
      @house = Oo::HauntedHouse.new(0)
      use("vacuum")
    end
    specify { @message.should eql("Switched on.") }
    specify { @house.rooms.current_room.ghosts.should be_false }
  end

  context "turret room" do
    before do
      @house = Oo::HauntedHouse.new(52)
      Random.any_instance.stub(:rand).with(any_args).and_return(1)
    end
    specify { @house.rooms.current_room.description.should eql("Upper Gallery") }
    specify { @house.rooms.current_room.ghosts.should be_true }

    context "try to move" do
      before do
        @message, @next_room = @house.rooms.current_room.go_direction("WEST")
      end
      specify { @message.should eql("Ghosts will not let you move.") }
      specify { @next_room.description.should eql("Upper Gallery") }
    end

    context "vacuum ghosts" do
      before do
        use("vacuum")
      end
      specify { @house.rooms.current_room.ghosts.should be_false }
      specify { @message.should eql("Whizz -- Vacuumed the ghosts up!") }

      context "try to move" do
        before do
          @message, @next_room = @house.rooms.current_room.go_direction(Oo::Direction::N)
        end
        specify { @next_room.description.should eql("Weird Cobwebby Room") }
      end
    end
  end

  def use(word)
    @house.rooms.inventory.carry(Oo::Things::BATTERIES)
    @house.rooms.inventory.carry(Oo::Things::VACUUM)
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input("use #{word}")
  end
end
