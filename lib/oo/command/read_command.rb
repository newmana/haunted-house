module Oo
  module Command
    class ReadCommand
      def verbs
        ["READ"]
      end

      def execute(verb, word, inventory, rooms)
        current_room = rooms.current_room
        if current_room.words.keys.include?(word)
          message, thing = current_room.words[word].read
          current_room.objects << thing unless thing.nil?
          return message
        end
        inventory.thing(word).read if inventory.carrying?(word)
      end
    end
  end
end