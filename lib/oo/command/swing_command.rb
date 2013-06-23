module Oo
  module Command
    class SwingCommand

      def verbs
        ["SWING"]
      end

      def execute(verb, word, house)
        house.inventory.thing(word).swing(house) if house.inventory.carrying?(word)
      end
    end
  end
end