require File.dirname(__FILE__) + "/../../../../lib/oo/haunted_house"

describe 'read command' do
  context "library" do
    before { @house = OO::HauntedHouse.new(42) }

    specify "should have correct description" do
      @house.current_room.description.should eql("Library of Evil Books")
    end

    context "read books" do
      before { read("books") }
      specify { @message.should eql("They are demonic works.") }
    end
  end

  context "read" do
    before do
      @house = OO::HauntedHouse.new(0)
    end

    context "read scroll" do
      before do
        @house.carry(Inventory::SCROLL)
        read("scroll")
      end
      specify { @message.should eql("The script is in an alien tongue.") }
    end
  end

  def read(object)
    parser = Parser.new(@house)
    @message = parser.parse_input("read #{object}")
  end
end
