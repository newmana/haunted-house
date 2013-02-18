require File.dirname(__FILE__) + "/../../../lib/oo/direction"
require File.dirname(__FILE__) + "/../../../lib/oo/rooms"
require File.dirname(__FILE__) + "/../../../lib/oo/rooms/room"

describe 'rooms' do
  describe "west east creation" do
    before(:each) do
      @object = Rooms.new
      Room.new(@object, "First Room")
      Room.new(@object, "Second Room")
    end

    context "Simple west east creation" do
      before { @object.route(0, [Direction::E]) }
      specify { @object.room(0).routes.should == {Direction::E => @object.room(1)} }
      specify { @object.room(1).routes.should == {Direction::W => @object.room(0)} }
    end
  end

  describe "north south creation" do
    before(:each) do
      @object = Rooms.new
      Room.new(@object, "First Room")
      (0..7).each { Room.new(@object, "Empty Room") }
      Room.new(@object, "Second Room")
    end

    context "Simple west east creation" do
      before { @object.route(0, [Direction::S]) }
      specify { @object.room(0).routes.should == {Direction::S => @object.room(8)} }
      specify { @object.room(8).routes.should == {Direction::N => @object.room(0)} }
    end
  end
end
