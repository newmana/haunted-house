module Oo
  module Command
    class LightCommand

      def verbs
        ["LIGHT"]
      end

      def execute(verb, word, house)
        house.inventory.thing(word).light(house) if house.inventory.carrying?(word)
      end
    end
  end
end