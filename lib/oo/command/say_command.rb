module Oo
  module Command
    class SayCommand
      def verbs
        ["SAY"]
      end

      def execute(verb, word, house)
        message = "Ok #{word}"
        if house.carrying?(Oo::Inventory::MAGIC_SPELLS) && word.eql?("XZANFAR")
          message = "*Magic Occurs*"
          house.current_room.magic_occurs
        end
        message
      end
    end
  end
end