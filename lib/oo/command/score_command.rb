require_relative 'press_enter'

module Oo
  module Command
    class ScoreCommand
      include PressEnter

      def verbs
        ["SCORE"]
      end

      def execute(verb, word, house)
        score = house.score
        puts "Your score #{score}"
        press_enter_to_continue
      end
    end
  end
end