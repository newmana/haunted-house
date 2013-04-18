module Oo
  module Command
    class LightCommand

      def verbs
        ["LIGHT"]
      end

      def execute(verb, word, house)
        house.thing(word).light(house) if house.carrying?(word)
      end
    end
  end
end