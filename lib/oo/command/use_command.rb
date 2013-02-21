module Oo
  module Command
    class UseCommand

      def verbs
        ["USE"]
      end

      def execute(verb, word, house)
        house.thing(word).use(house) if house.carrying?(word)
      end
    end
  end
end