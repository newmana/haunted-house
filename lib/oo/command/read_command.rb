module Oo
  module Command
    class ReadCommand
      def verbs
        ["READ"]
      end

      def execute(verb, word, house)
        current_room = house.current_room
        if current_room.words.keys.include?(word)
          message, thing = current_room.words[word].read
          current_room.objects << thing unless thing.nil?
          return message
        end
        house.inventory.thing(word).read if house.inventory.carrying?(word)
      end
    end
  end
end