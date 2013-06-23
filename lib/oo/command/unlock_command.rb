module Oo
  module Command
    class UnlockCommand

      def verbs
        ["UNLOCK"]
      end

      def execute(verb, word, house)
        current_room = house.current_room
        if current_room.words.keys.include?(word)
          if house.inventory.carrying?(Oo::Things::KEY)
            house.inventory.thing("KEY").unlock(house)
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