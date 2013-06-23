module Oo
  module Command
    class ExamineCommand
      def verbs
        ["EXAMINE"]
      end

      def execute(verb, word, inventory, rooms)
        current_room = rooms.current_room
        if current_room.words.keys.include?(word)
          message, thing = current_room.words[word].examine
          current_room.objects << thing unless thing.nil?
          return message
        end
        inventory.thing(word).examine if inventory.carrying?(word)
      end
    end
  end
end
