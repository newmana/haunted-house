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

  def go(direction)
    parser = Oo::Command::Parser.new(@house)
    @message = parser.parse_input("#{direction}")
  end
end
