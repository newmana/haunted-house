require 'oo/direction'
require 'oo/room'

describe 'direction' do
  describe "west east creation" do
    before(:each) do
      @rooms = [Room.new("First Room"), Room.new("Second Room")]
    end

    context "Simple west east creation" do
      before { Direction.route(@rooms, 0, [Direction::E]) }
      specify { @rooms[0].routes.should == {Direction::E => @rooms[1]} }
      specify { @rooms[1].routes.should == {Direction::W => @rooms[0]} }
    end
  end

  describe "north south creation" do
    before(:each) do
      @rooms = [Room.new("First Room")]
      @rooms[8] = Room.new("Second Room")
    end

    context "Simple west east creation" do
      before { Direction.route(@rooms, 0, [Direction::N]) }
      specify { @rooms[0].routes.should == {Direction::N => @rooms[8]} }
      specify { @rooms[8].routes.should == {Direction::S => @rooms[0]} }
    end
  end
end
