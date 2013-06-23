module Oo
  module Command
    class DigCommand
      def verbs
        ["DIG"]
      end

      def execute(verb, word, inventory, rooms)
        inventory.thing("SHOVEL").dig(rooms.current_room) if inventory.carrying?(Oo::Things::SHOVEL)
      end
    end
  end
end
