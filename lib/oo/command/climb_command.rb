module Oo
  module Command
    class ClimbCommand

      def verbs
        ["CLIMB"]
      end

      def execute(verb, word, inventory, rooms)
        if inventory.carrying?(word)
          inventory.thing(word).climb
        else
          rooms.current_room.climb
        end
      end
    end
  end
end
