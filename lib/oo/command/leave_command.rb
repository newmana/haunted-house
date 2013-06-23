module Oo
  module Command
    class LeaveCommand
      def verbs
        ["LEAVE"]
      end

      def execute(verb, word, house)
        if house.inventory.carrying?(word)
          house.inventory.leave(word)
          house.current_room.objects << house.inventory.to_up_sym(word)
          "Done"
        end
      end
    end
  end
end