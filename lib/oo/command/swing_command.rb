module Oo
  module Command
    class SwingCommand

      def verbs
        ["SWING"]
      end

      def execute(verb, word, house)
        house.thing(word).swing(house) if house.carrying?(word)
      end
    end
  end
end