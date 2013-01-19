require File.dirname(__FILE__) + "/../../../lib/oo/direction"
require File.dirname(__FILE__) + "/../../../lib/oo/room"

describe 'direction' do
  describe "west east creation" do
    before(:each) do
      @rooms = [Room.new("First Room"), Room.new("Second Room")]
      @object = TestRooms.new(@rooms)
    end

    context "Simple west east creation" do
      before { @object.route(0, [Direction::E]) }
      specify { @rooms[0].routes.should == {Direction::E => @rooms[1]} }
      specify { @rooms[1].routes.should == {Direction::W => @rooms[0]} }
    end
  end

  describe "north south creation" do
    before(:each) do
      @rooms = [Room.new("First Room")]
      @rooms[8] = Room.new("Second Room")
      @object = TestRooms.new(@rooms)
    end

    context "Simple west east creation" do
      before { @object.route(0, [Direction::S]) }
      specify { @rooms[0].routes.should == {Direction::S => @rooms[8]} }
      specify { @rooms[8].routes.should == {Direction::N => @rooms[0]} }
    end
  end

  class TestRooms
    include Direction

    def initialize(rooms)
      @rooms = rooms
    end

  end
end
