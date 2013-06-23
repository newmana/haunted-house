module Oo
  module Command
    class SayCommand
      def verbs
        ["SAY"]
      end

      def execute(verb, word, house)
        message = "#{word}"
        if house.inventory.carrying?(Oo::Things::MAGIC_SPELLS) && word.eql?("XZANFAR")
          message = "*Magic Occurs*"
          house.current_room.magic_occurs
        end
        message
      end
    end
  end
end