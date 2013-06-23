module Oo
  module Command
    class LeaveCommand
      def verbs
        ["LEAVE"]
      end

      def execute(verb, word, inventory, rooms)
        if inventory.carrying?(word)
          inventory.leave(word)
          rooms.current_room.objects << inventory.to_up_sym(word)
          "Done"
        end
      end
    end
  end
end