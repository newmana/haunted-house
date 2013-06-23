module Oo
  module Command
    class LightCommand

      def verbs
        ["LIGHT"]
      end

      def execute(verb, word, inventory, rooms)
        inventory.thing(word).light(inventory) if inventory.carrying?(word)
      end
    end
  end
end