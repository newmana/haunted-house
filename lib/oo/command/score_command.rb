require_relative 'press_enter'

module Oo
  module Command
    class ScoreCommand
      include PressEnter

      def verbs
        ["SCORE"]
      end

      def execute(verb, word, inventory, rooms)
        score = inventory.score
        score = rooms.current_room.score(inventory.carrying?(Oo::Things::BOAT), score) if score == 17
        puts "Your score #{score}"
        if score > 18
          puts "Well done! You finished the game."
          exit(true)
        end
        press_enter_to_continue
      end
    end
  end
end