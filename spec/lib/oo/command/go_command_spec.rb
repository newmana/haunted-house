require "oo/haunted_house"

describe 'go command' do
  context "start" do
    before { @house = Oo::HauntedHouse.new }

    context "go north" do
      before { go("go north") }

      specify "ok" do
        @message.should eql("Ok")
      end
    end

    context "n" do
      before { go("n") }

      specify "ok" do
        @message.should eql("Ok")
      end
    end

    context "go wrong name for a direction" do
      before { go("go whereever") }

      specify "where" do
        @message.should eql("Go where?")
      end
    end
  end

  context "You need a light going north or east" do
    before { @house = Oo::HauntedHouse.new(26) }

    specify "try go north" do
      go("n")
      @message.should eql("You need a light.")
    end

    specify "try go east" do
      go("e")
      @message.should eql("You need a light.")
    end
  end

  context "bottom of spiral staircase" do
    before { @house = Oo::HauntedHouse.new(20) }

    specify { @house.current_room.description.should eql("Bottom of a Spiral Staircase") }

    context "go up" do
      before { go("go up") }

      specify { @message.should eql("Ok") }
      specify { @house.current_room.description.should eql("Room with Inches of Dust") }
    end
  end

  def go(direction)
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input("#{direction}")
  end

end
