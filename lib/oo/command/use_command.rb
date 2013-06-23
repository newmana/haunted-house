module Oo
  module Command
    class UseCommand

      def verbs
        ["USE"]
      end

      def execute(verb, word, inventory, rooms)
        inventory.thing(word).use(inventory, rooms) if inventory.carrying?(word)
      end
    end
  end
end