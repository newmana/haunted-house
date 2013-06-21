module Oo
  module Command
    class UnlockCommand

      def verbs
        ["UNLOCK"]
      end

      def execute(verb, word, house)
        current_room = house.current_room
        if current_room.words.keys.include?(word)
          if house.carrying?(Oo::Inventory::KEY)
            house.thing("KEY").unlock(house)
          else
            current_room.words[word].unlock
          end
        end
      end
    end
  end
end