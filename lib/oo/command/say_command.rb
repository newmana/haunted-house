module Oo
  module Command
    class SayCommand
      def verbs
        ["SAY"]
      end

      def execute(verb, word, inventory, rooms)
        message = "#{word}"
        if inventory.carrying?(Oo::Things::MAGIC_SPELLS) && word.eql?("XZANFAR")
          message = "*Magic Occurs*"
          rooms.current_room.magic_occurs
        end
        message
      end
    end
  end
end