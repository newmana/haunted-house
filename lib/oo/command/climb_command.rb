module Oo
  module Command
    class ClimbCommand

      def verbs
        ["CLIMB"]
      end

      def execute(verb, word, house)
        if house.inventory.carrying?(word)
          house.inventory.thing(word).climb
        else
          house.current_room.climb
        end
      end
    end
  end
end
