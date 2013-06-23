module Oo
  module Command
    class UseCommand

      def verbs
        ["USE"]
      end

      def execute(verb, word, house)
        house.inventory.thing(word).use(house) if house.inventory.carrying?(word)
      end
    end
  end
end