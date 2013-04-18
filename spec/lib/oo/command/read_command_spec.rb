require "oo/haunted_house"

describe 'read command' do
  context "library" do
    before { @house = Oo::HauntedHouse.new(42) }

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
      @house = Oo::HauntedHouse.new(0)
    end

    context "read scroll" do
      before do
        @house.carry(Oo::Inventory::SCROLL)
        read("scroll")
      end
      specify { @message.should eql("The script is in an alien tongue.") }
    end
  end

  def read(object)
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input("read #{object}")
  end
end
