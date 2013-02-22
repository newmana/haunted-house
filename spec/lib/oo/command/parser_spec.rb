require 'spec_helper'
require 'oo/haunted_house'
require 'oo/command/parser'

describe "parser" do
  context "house" do
    before { @house = Oo::HauntedHouse.new }

    context "validate" do
      before { @parser = Oo::Command::Parser.new(@house) }

      specify "is silly if we can't find the word" do
        message, verb, word = @parser.validate("SPRAY paint")
        verb.should eql("SPRAY")
        word.should eql("PAINT")
        message.should eql("That's silly")
      end

      specify "requires two words" do
        message, verb, word = @parser.validate("SPRAY")
        verb.should eql("SPRAY")
        word.should eql("")
        message.should eql("I need two words")
      end

      specify "is you can't if the verb is wrong but the object is correct" do
        message, verb, word = @parser.validate("george AEROSOL")
        verb.should eql("GEORGE")
        word.should eql("AEROSOL")
        message.should eql("You can't 'GEORGE AEROSOL'")
      end

      specify "doesn't find the verb and object" do
        message, verb, word = @parser.validate("FOO BAR")
        verb.should eql("FOO")
        word.should eql("BAR")
        message.should eql("You don't make sense")
      end

      specify "check whether you are carrying" do
        message, verb, word = @parser.validate("USE MATCHES")
        verb.should eql("USE")
        word.should eql("MATCHES")
        message.should eql("You don't have MATCHES")
      end
    end
  end
end
