require File.dirname(__FILE__) + "/../../../../lib/oo/haunted_house"

describe 'use command' do
  context "anywhere" do
    before do
      @house = OO::HauntedHouse.new(0)
      use("vacuum")
    end
    specify { @message.should eql("Switched on.") }
    specify { @house.current_room.ghosts.should be_false }
  end

  context "turret room" do
    before do
      @house = OO::HauntedHouse.new(52)
      Random.any_instance.stub(:rand).with(any_args).and_return(1)
    end
    specify { @house.current_room.description.should eql("Upper Gallery") }
    specify { @house.current_room.ghosts.should be_true }

    context "try to move" do
      before do
        @message, @next_room = @house.current_room.go_direction("WEST")
      end
      specify { @message.should eql("Ghosts will not let you move.") }
      specify { @next_room.description.should eql("Upper Gallery") }
    end

    context "vacuum ghosts" do
      before do
        use("vacuum")
      end
      specify { @house.current_room.ghosts.should be_false }
      specify { @message.should eql("Whizz -- Vacuumed the ghosts up!") }

      context "try to move" do
        before do
          @message, @next_room = @house.current_room.go_direction(Direction::N)
        end
        specify { @next_room.description.should eql("Weird Cobwebby Room") }
      end
    end
  end

  def use(word)
    @house.carry(Inventory::BATTERIES)
    @house.carry(Inventory::VACUUM)
    parser = Parser.new(@house)
    @message = parser.parse_input("use #{word}")
  end
end
