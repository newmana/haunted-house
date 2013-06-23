require 'spec_helper'
require 'oo/direction'
require 'oo/rooms'
require 'oo/rooms/room'

describe 'rooms' do
  describe "west east creation" do
    before(:each) do
      @house = Oo::HauntedHouse.new(1)
      @object = Oo::Rooms.new
      Room.new(@house, @object, "First Room")
      Room.new(@house, @object, "Second Room")
    end

    context "Simple west east creation" do
      before { @object.route(0, [Oo::Direction::E]) }
      specify { @object.room(0).routes.should == {Oo::Direction::E => @object.room(1)} }
      specify { @object.room(1).routes.should == {Oo::Direction::W => @object.room(0)} }
    end
  end

  describe "north south creation" do
    before(:each) do
      @object = Oo::Rooms.new
      Room.new(@house, @object, "First Room")
      (0..7).each { Room.new(@house, @object, "Empty Room") }
      Room.new(@house, @object, "Second Room")
    end

    context "Simple west east creation" do
      before { @object.route(0, [Oo::Direction::S]) }
      specify { @object.room(0).routes.should == {Oo::Direction::S => @object.room(8)} }
      specify { @object.room(8).routes.should == {Oo::Direction::N => @object.room(0)} }
    end
  end
end
