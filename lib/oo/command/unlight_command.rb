module Oo
  module Command
    class UnlightCommand

      def verbs
        ["UNLIGHT"]
      end

      def execute(verb, word, inventory, rooms)
        inventory.thing(word).unlight if inventory.carrying?(word)
      end
    end
  end
end