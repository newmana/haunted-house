module Oo
  module Command
    class ExamineCommand
      def verbs
        ["EXAMINE"]
      end

      def execute(verb, word, house)
        current_room = house.current_room
        if current_room.words.keys.include?(word)
          message, thing = current_room.words[word].examine
          current_room.objects << thing unless thing.nil?
          return message
        end
        house.inventory.thing(word).examine if house.inventory.carrying?(word)
      end
    end
  end
end
