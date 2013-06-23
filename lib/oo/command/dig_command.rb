module Oo
  module Command
    class DigCommand
      def verbs
        ["DIG"]
      end

      def execute(verb, word, house)
        house.inventory.thing("SHOVEL").dig(house) if house.inventory.carrying?(Oo::Things::SHOVEL)
      end
    end
  end
end
