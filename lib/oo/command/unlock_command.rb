module Oo
  module Command
    class UnlockCommand

      def verbs
        ["UNLOCK"]
      end

      def execute(verb, word, inventory, rooms)
        current_room = rooms.current_room
        if current_room.words.keys.include?(word)
          if inventory.carrying?(Oo::Things::KEY)
            inventory.thing("KEY").unlock(rooms)
          else
            message, thing = current_room.words[word].unlock
            current_room.objects << thing unless thing.nil?
            return message
          end
        end
      end
    end
  end
end