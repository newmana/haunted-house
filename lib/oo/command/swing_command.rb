module Oo
  module Command
    class SwingCommand

      def verbs
        ["SWING"]
      end

      def execute(verb, word, inventory, rooms)
        inventory.thing(word).swing(rooms) if inventory.carrying?(word)
      end
    end
  end
end